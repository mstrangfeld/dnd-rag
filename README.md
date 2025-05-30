# D&D RAG Exploration

A comprehensive project exploring advanced Retrieval-Augmented Generation (RAG) techniques applied to Dungeons & Dragons content, including rulebooks, lore, and game mechanics.

## Table of Contents

- [Overview](#overview)
- [Research Areas](#research-areas)
  - [Core RAG Optimization](#core-rag-optimization)
  - [Advanced Retrieval Methods](#advanced-retrieval-methods)
  - [Knowledge Representation](#knowledge-representation)
  - [AI Agent Capabilities](#ai-agent-capabilities)
  - [Uncertainty and Reasoning](#uncertainty-and-reasoning)
- [Copyright](#copyright)
- [License](#license)

## Overview

This project investigates different RAG techniques to create an intelligent D&D assistant capable of understanding complex queries about game rules, lore, character mechanics, and strategic gameplay.
The research focuses on both technical optimization and novel approaches to information retrieval and reasoning.

## Research Areas

### Core RAG Optimization

#### Optimizing Chunk and Embedding Sizes for Semantic Retrieval
**What it is**: Experimenting with different sizes of text segments (chunks) from source materials and various methods of converting these chunks into numerical representations (embeddings).

**Why it matters**: Optimal chunk and embedding sizes ensure that the system retrieves the most relevant passages when users ask questions. Too small chunks might miss context, while too large chunks might be too general. The right embedding model captures the semantic meaning of D&D terms and concepts effectively.

#### Comparing Sparse Retrieval Methods (BM25, SPLADE, SPLADE++)
**What it is**: Sparse retrieval methods are primarily keyword-based. BM25 is a classical algorithm that ranks documents based on term frequency. SPLADE and its variants learn to expand and weight query/document terms for better matching.

**Why it matters**: For D&D content, specific names of entities, spells, and domain-specific terms are crucial. Sparse retrieval can excel at finding documents containing these exact terms, making it ideal for precise rule lookups.

#### Evaluating Reranking Techniques (Cross-Encoders, ColBERT, LLM-based)
**What it is**: After initial retrieval, rerankers take the top N results and re-evaluate their relevance more carefully. Cross-Encoders process query and document pairs together, ColBERT uses token-level interactions, and LLM-based reranking uses large language models to judge relevance.

**Why it matters**: Rerankers improve precision by prioritizing the most relevant information. For ambiguous D&D queries, powerful rerankers can better discern user intent and surface the correct rules or lore entries.

### Advanced Retrieval Methods

#### Query Expansion with HyDE
**What it is**: Hypothetical Document Embeddings (HyDE) involves an LLM generating a hypothetical answer to the query, embedding that answer, and using this embedding to find similar actual documents.

**Why it matters**: D&D players might not always know exact terminology. HyDE bridges this gap by generating context-rich versions of queries, leading to more comprehensive information retrieval.

#### Traditional RAG vs. Agentic Tool Use for Interactive Retrieval
**What it is**: Traditional RAG retrieves documents and synthesizes answers in a single pass. An agentic approach involves an LLM that can use tools iteratively, plan, and ask clarifying questions for complex, multi-step information needs.

**Why it matters**: Complex D&D questions like "Compare Circle of the Moon vs Circle of the Land Druids across different editions" require multiple retrieval steps and synthesis. Agents can perform comprehensive comparisons that single-pass RAG cannot handle effectively.

### Knowledge Representation

#### Graph-Based RAG
**What it is**: Using NLP techniques to extract entities (spells, monsters, characters, rules) and their relationships from D&D texts, structuring this information as a knowledge graph.

**Why it matters**: Enables complex queries like "Show me all spells usable by a Level 3 Cleric that can heal and have a casting time of 1 action." The graph structure captures the interconnected nature of D&D mechanics.

#### Temporal Knowledge Graphs
**What it is**: Extending knowledge graphs with a time dimension to track changes in lore, rules, or entity attributes across different D&D editions.

**Why it matters**: Allows queries about how specific spells, classes, or rules evolved from AD&D through 5th Edition, providing historical context for rule discussions.

### AI Agent Capabilities

#### Long-Term Memory Implementation
**What it is**: Enabling AI agents to retain and recall information from past interactions using systems like the [Knowledge Graph Memory Server](https://github.com/modelcontextprotocol/servers/tree/main/src/memory).

**Why it matters**: Creates persistent context for ongoing campaigns, character development tracking, and personalized rule interpretations based on previous interactions.

### Uncertainty and Reasoning

#### Source Scoring and Reliability Assessment
**What it is**: Assigning confidence scores to information based on source reliability (official rulebooks vs. community wikis vs. forum discussions).

**Why it matters**: Allows the system to weigh official D&D sources higher while still incorporating community insights, presenting answers with appropriate confidence levels.

#### User Intent Scoring
**What it is**: Probabilistically inferring the user's underlying goal when queries are ambiguous.

**Why it matters**: Helps disambiguate queries like "Tell me about Fireball" by inferring whether users want spell mechanics, lore, tactical usage, or historical changes.

#### Causal Inference and Structural Causal Models
**What it is**: Techniques to understand cause-and-effect relationships in game mechanics and outcomes.

**Why it matters**: Enables strategic advice by modeling how character choices, spell combinations, and tactical decisions lead to specific outcomes in gameplay.

#### Temporal Reasoning with Event Calculus
**What it is**: Logic-based approaches to model events and their effects over time in game narratives and mechanics.

**Why it matters**: Tracks spell durations, character state changes, and narrative sequences, enabling accurate answers to time-related questions about game mechanics.

#### Information-Theoretic Dialogue Management
**What it is**: Framing dialogue as Bayesian decision problems where the system chooses actions to efficiently satisfy user information needs while reducing uncertainty about user intent.

**Why it matters**: Creates more intelligent assistants that actively clarify ambiguous D&D questions, leading to more efficient and satisfying interactions.

#### Theory of Mind Modeling
**What it is**: Endowing AI with the ability to model user mental states—their D&D knowledge level, campaign context, and preferences.

**Why it matters**: Enables personalized responses that provide appropriate detail levels for novice vs. expert players and context-aware assistance for specific campaign needs.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

## Copyright

This work includes material taken from the [System Reference Document 5.2.1 (“SRD 5.2.1”)](https://www.dndbeyond.com/srd) by Wizards of the Coast LLC .
The SRD 5.2.1 is licensed under the Creative Commons Attribution 4.0 International License.

I am not affiliated with Dungeons & Dragons or Wizards of The Coast in any way.

## License

Copyright 2025 Marvin Strangfeld

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

[http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
