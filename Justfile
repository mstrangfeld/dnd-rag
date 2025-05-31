# Justfile

# Default task: running 'just' will execute 'just build'
default: build

# Build task: currently set to convert notebooks. Expand as needed.
build: convert-notebooks
    @echo "Build process triggered: Notebooks converted."

# Convert all Jupyter notebooks to Markdown for MkDocs
convert-notebooks:
    #!/usr/bin/env bash
    set -euxo pipefail
    
    # Base directory for all source notebooks
    source_base_dir="research"
    # Base directory for all converted markdown files
    output_docs_base_dir="docs/research"
    
    # Ensure the root output directory exists
    mkdir -p "$output_docs_base_dir"

    # Find all Jupyter notebooks in the source_base_dir directory
    find "$source_base_dir" -name "*.ipynb" | while read -r notebook_path; do
        # Example notebook_path: research/engineering/00_naive-rag/langgraph.ipynb

        # Get the path of the notebook relative to the source_base_dir
        # Example: engineering/00_naive-rag/langgraph.ipynb
        relative_notebook_path="${notebook_path#$source_base_dir/}"

        # Define the output directory for the markdown file, preserving structure
        # Example: docs/research/engineering/00_naive-rag
        output_md_subdir="$output_docs_base_dir/$(dirname "$relative_notebook_path")"

        # Define the name of the output markdown file (without .ipynb extension)
        # Example: langgraph.md
        output_md_filename="$(basename "$relative_notebook_path" .ipynb).md"
        
        # Define the full relative path for the output markdown file
        # Example: docs/research/engineering/00_naive-rag/langgraph.md
        full_output_md_path="$output_md_subdir/$output_md_filename"

        # Create the target subdirectory if it doesn't exist
        mkdir -p "$output_md_subdir"

        # Convert the notebook to Markdown using nbconvert
        # Output to the structured directory with the correct filename
        jupyter nbconvert --to markdown "$notebook_path" --output "$output_md_filename" --output-dir "$output_md_subdir"
        
        echo "Converted $notebook_path to $full_output_md_path"
    done
    echo "All notebooks converted."


# Alias for convenience: 'just notebooks' will run 'just convert-notebooks'
notebooks: convert-notebooks
