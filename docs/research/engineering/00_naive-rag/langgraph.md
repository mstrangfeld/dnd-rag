# Naive RAG with LangGraph

Welcome to your first hands-on exploration of **Retrieval-Augmented Generation (RAG)** using one of the most popular AI frameworks available today!

## 🎯 What You'll Learn

In this interactive tutorial, we'll build a simple but functional RAG system from scratch using:

- **LangChain** for document processing and embeddings
- **LangGraph** for orchestrating our RAG workflow
- **FastEmbed** for efficient text embeddings
- **Claude 3.5 Sonnet** as our language model

By the end of this notebook, you'll have a working D&D assistant that can answer questions about character information using semantic search and AI generation.

## 🔄 The RAG Process

RAG combines two powerful AI techniques:

1. **Retrieval**: Finding relevant information from a knowledge base
2. **Generation**: Using an LLM to synthesize answers from retrieved context

---


## 📚 Step 1: Document Indexing

The first step in any RAG system is preparing our knowledge base. We need to take our raw text data and transform it into a searchable format.

### 🔧 Text Splitting Strategy

For effective retrieval, we need to split our documents into **coherent chunks**. Too large, and we lose precision; too small, and we lose context.

We'll use **Markdown Header Text Splitting** because:

- ✅ Preserves semantic structure
- ✅ Maintains logical document boundaries
- ✅ Keeps related information together

Let's load our D&D character data and split it into searchable chunks:



```python
from langchain_text_splitters import MarkdownHeaderTextSplitter

file_path = "characters.md"

# Read the content of the file
with open(file_path, "r", encoding="utf-8") as f:
    text = f.read()

headers_to_split_on = [
    ("#", "Header 1"),
]

# Initialize a text splitter
text_splitter = MarkdownHeaderTextSplitter(
    headers_to_split_on=headers_to_split_on, strip_headers=False
)

documents = text_splitter.split_text(text)

print(f"Split into {len(documents)} documents.")
```

    Split into 20 documents.


### 🧠 Creating Semantic Representations

To make these text chunks semantically searchable, we need to convert them into **embeddings** - numerical representations that capture meaning.

#### How Embeddings Work

An embedding model "compresses" each text chunk into a high-dimensional vector space (in our case 384 dimensions).
Similar concepts end up close together in this space, enabling semantic search.

For example:

- "Fighter class abilities" and "Warrior combat features" would have similar embeddings
- "Spellcasting rules" and "Magic system" would cluster together

We'll use **FastEmbed** because it is lightweight and fast on CPU. Perfect for experimentation:



```python
from langchain_community.embeddings.fastembed import FastEmbedEmbeddings

embeddings = FastEmbedEmbeddings()
```

### 🗃️ Setting Up the Vector Database

Now we need a place to store and search our embeddings efficiently.
A **vector database** is optimized for similarity search in high-dimensional spaces.



```python
from langchain_core.vectorstores import InMemoryVectorStore

vector_store = InMemoryVectorStore(embeddings)
```

### ⚡ Indexing the Documents

Now for the magic! We'll add our text chunks to the vector store. This process automatically:

1. 📝 Takes each document chunk
2. 🔢 Converts it to an embedding vector
3. 💾 Stores both the text and vector for fast retrieval

This is where the "index" in RAG gets built:



```python
# Index chunks
_ = vector_store.add_documents(documents=documents)
```

## 🔍 Step 2: Retrieval & Generation

With our knowledge base indexed, we can now build the query-answering pipeline! This involves two key components:

1. **🔍 Retrieval**: Finding relevant documents based on semantic similarity
2. **✨ Generation**: Using an LLM to synthesize natural answers from retrieved context

### 🤖 Setting Up the Language Model

First, let's initialize our AI model. We'll use **Claude 3.5 Sonnet**.



```python
import getpass
import os

from langchain.chat_models import init_chat_model

if not os.environ.get("ANTHROPIC_API_KEY"):
    os.environ["ANTHROPIC_API_KEY"] = getpass.getpass("Enter API key for Anthropic: ")

llm = init_chat_model("claude-3-5-sonnet-latest", model_provider="anthropic")
```


```python
# Test if the model is working
response = llm.invoke(
    "What is the name of the god that is known as the Morninglord in the Forgotten Realms setting? Only respond with the name of the god, nothing else."
)
print(response.content)
```

    Lathander


### 🔗 Orchestrating the RAG Pipeline

Now for the exciting part - putting it all together! We'll use **LangGraph** to create a workflow that:

1. 📥 Takes a user question
2. 🔍 Retrieves relevant document chunks
3. 🤖 Generates an answer using the retrieved context
4. 📤 Returns the final response



```python
from langchain_core.documents import Document
from langgraph.graph import START, StateGraph
from typing_extensions import List, TypedDict
from langchain_core.prompts import PromptTemplate

prompt = PromptTemplate.from_template("""
        You are an assistant for question-answering tasks. Use the following pieces of retrieved context to answer the question. If you don't know the answer, just say that you don't know. Use three sentences maximum and keep the answer concise.
        Question: {question} 
        Context: {context} 
        Answer:
    """)


# Define state for application
class State(TypedDict):
    question: str
    context: List[Document]
    answer: str


# Define application steps
def retrieve(state: State):
    retrieved_docs = vector_store.similarity_search(state["question"])
    return {"context": retrieved_docs}


def generate(state: State):
    docs_content = "\n\n".join(doc.page_content for doc in state["context"])
    messages = prompt.invoke({"question": state["question"], "context": docs_content})
    response = llm.invoke(messages)
    return {"answer": response.content}


# Compile application and test
graph_builder = StateGraph(State).add_sequence([retrieve, generate])
graph_builder.add_edge(START, "retrieve")
graph = graph_builder.compile()
```

## 🧪 Step 3: Testing Our RAG System

Time to see our D&D assistant in action! Let's test it with a question about our characters:



```python
response = graph.invoke({"question": "Who is Tiamat?"})
print(response["answer"])
```

    Tiamat is the five-headed chromatic dragon goddess of evil who rules over Avernus. She appears as both a deity and a powerful endgame boss in various D&D settings including Dragonlance and Forgotten Realms.

