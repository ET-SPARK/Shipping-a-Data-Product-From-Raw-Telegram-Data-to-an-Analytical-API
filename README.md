# Shipping a Data Product From Raw Telegram Data to an Analytical API

An end-to-end data pipeline for Telegram, leveraging dbt for transformation, Dagster for orchestration, and YOLOv8 for data enrichment.

## Project Setup

This project is set up to be reproducible and professional.

-   **Version Control:** The project is a Git repository.
-   **Dependency Management:** Python dependencies are managed in `requirements.txt`.
-   **Containerization:** The application is containerized using Docker and Docker Compose (`Dockerfile`, `docker-compose.yml`). This ensures a consistent environment for development and deployment.
-   **Secrets Management:** Secrets (API keys, passwords) are stored in a `.env` file, which is ignored by Git (`.gitignore`) to prevent accidental commits. The `python-dotenv` library is used to load these secrets as environment variables.
-   **Virtual Environment:** A Python virtual environment (`venv`) is used for local development to isolate project dependencies.

## Task 1: Data Scraping and Collection (Extract & Load)

The first phase of the project involves scraping data from public Telegram channels.

-   **Telegram Scraping:** A Python script using the `telethon` library extracts messages and images from specified public channels.
    -   **Channels:**
        -   `lobelia4cosmetics`
        -   `tikvahpharma`
        -   `Chemedhealth`
-   **Data Lake:** The raw, unaltered data is stored in a local directory structure that acts as a data lake.
    -   **Structure:** Data is partitioned by date and channel name for easy incremental processing (e.g., `data/raw/telegram_messages/YYYY-MM-DD/channel_name.json`).
    -   **Format:** Raw message data is stored as JSON files, preserving the original API structure. Images are saved in a parallel structure.
-   **Logging:** The scraper includes robust logging to monitor which channels and dates have been processed and to capture any errors.