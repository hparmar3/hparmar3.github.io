# Markov Chain Text Generator
This Google Colab notebook demonstrates how to build a simple Markov chain model for text generation. It leverages the Project Gutenberg library to acquire text from classic literature, processes it to create a probabilistic model of word sequences, and then uses this model to generate new, random text.

## How it Works
1. <b> Dependencies: </b> Installs necessary libraries (`gutenberg`) and system packages (`libdb-dev`) for text acquistion and processing.
2. <b> Text Aquisition: </b> Downloads and cleans text from specified books from Project Gutenberg (e.g., 'Amusements in Mathematics' and 'Don Quixote').
3. <b> Markov Chain Construction: </b> Builds a Markov chain by analyzing the downloaded text. For each word, it stores a list of words that frequently follow it.
4. <b> Text Generation: </b> Generates new text by starting with a random word and then sequentially picking the next word based on the probabilities learned from the Markov chain.

## Usage
- Run all cells in the notebook
- The output will be a randomly generated text snippet (10 words by default) based on the combined texts of the chosen books
- You can modifiy `texts` list to include different Project Gutenberg book IDs to generate text from other sources
- The `generate_text` function's `length` parameter can be adjusted to control the length of the generated text
