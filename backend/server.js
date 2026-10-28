
require('dotenv').config();

const express = require('express');
const cors = require('cors');

const app = express();
const port = process.env.PORT || 3000;

const apiKey = process.env.GEMINI_API_KEY;

if (!apiKey) {
  throw new Error('GEMINI_API_KEY is missing from backend/.env');
}

app.use(cors());
app.use(express.json({ limit: '2mb' }));

app.get('/', (req, res) => {
  res.json({ message: 'DocChat backend is running.' });
});

async function generateAnswer(question, pdfText) {
  const controller = new AbortController();
  const timeout = setTimeout(() => controller.abort(), 60000);

  try {
    const response = await fetch(
      `https://generativelanguage.googleapis.com/v1beta/models/gemini-3.5-flash-lite:generateContent?key=${apiKey}`,
      {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          contents: [
            {
              parts: [
                {
                  text: `Answer the question using only the document below.
If the answer is not in the document, say so.

DOCUMENT:
${pdfText.slice(0, 50000)}

QUESTION:
${question}`,
                },
              ],
            },
          ],
        }),
        signal: controller.signal,
      }
    );

    const data = await response.json();

    if (!response.ok) {
      throw new Error(
        `Gemini API returned ${response.status}: ${JSON.stringify(data)}`
      );
    }

    return (
      data.candidates?.[0]?.content?.parts
        ?.map((part) => part.text || '')
        .join('') || 'No answer was generated.'
    );
  } catch (error) {
    if (error.name === 'AbortError') {
      throw new Error('Gemini request timed out after 15 seconds.');
    }

    throw error;
  } finally {
    clearTimeout(timeout);
  }
}
app.post('/api/test', (req, res) => {
  console.log('POST /api/test reached');

  res.json({
    success: true,
    message: 'POST request received successfully.',
    body: req.body,
  });
});
app.post('/api/chat', async (req, res) => {
  try {
  console.log('POST /api/chat reached');
    const { question, pdfText } = req.body || {};

    if (
      typeof question !== 'string' ||
      !question.trim() ||
      typeof pdfText !== 'string' ||
      !pdfText.trim()
    ) {
      return res.status(400).json({
        error: 'A question and PDF text are required.',
      });
    }

    console.log('Received chat request. Sending it to Gemini...');

    const answer = await generateAnswer(question, pdfText);

    console.log('Gemini response received successfully.');

    return res.json({ answer });
  } catch (error) {
    console.error('AI request failed:', error.message);

    return res.status(502).json({
      error: error.message || 'Unable to generate an answer.',
    });
  }
});

app.listen(port, '0.0.0.0', () => {
  console.log(`DocChat backend listening on port ${port}`);
});
