# Shipping a Data Product From Raw Telegram Data to an Analytical API

An end-to-end data pipeline for Telegram, leveraging dbt for transformation, Dagster for orchestration, and YOLOv8 for data enrichment.

## Project Structure

The following outlines the project's file and directory structure, which is consistently maintained across all branches. New files and directories created during feature development are integrated into this established structure.

```
.github/workflows/main.yml  # CI/CD pipeline
data/                       # Raw data lake (ignored by git)
scraper/                    # Python scripts for data scraping
  main.py
scripts/                    # Helper scripts (e.g., data loading)
  load_to_postgres.py
telegram_analytics/         # dbt project for data transformation
  models/
    staging/
    marts/
.env                        # Environment variables (ignored by git)
.gitignore                  # Git ignore file
Dockerfile                  # Docker container definition
docker-compose.yml          # Docker services configuration
requirements.txt            # Python dependencies
README.md                   # Project documentation
```

## Branching Strategy

This project follows a simple feature-branching workflow:

-   **`main`:** This is the primary branch. It should always be stable and deployable.
-   **Feature Branches (e.g., `task-1`, `feat/add-new-feature`):** All new work is done in a dedicated feature branch. When the work is complete, the branch is merged into `main`.

## Usage

1.  **Clone the repository:**
    ```bash
    git clone <repository-url>
    cd <repository-name>
    ```

2.  **Set up the environment:**
    -   Create a `.env` file from the `.env.example` (if provided) or manually add the required variables (`TELEGRAM_API_ID`, `TELEGRAM_API_HASH`, `POSTGRES_DB`, etc.).
    -   Create a Python virtual environment: `python -m venv venv`
    -   Activate it: `source venv/bin/activate`
    -   Install dependencies: `pip install -r requirements.txt`

3.  **Run the scraper:**
    -   The first time, you will be prompted for your Telegram credentials.
    ```bash
    python scraper/main.py
    ```

4.  **Load data into PostgreSQL:**
    ```bash
    python scripts/load_to_postgres.py
    ```

5.  **Run dbt transformations:**
    -   Navigate to the dbt project directory: `cd telegram_analytics`
    -   Run dbt models: `dbt run`
    -   Run dbt tests: `dbt test`

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

## Task 2: Data Modeling and Transformation (Transform)

This task uses dbt to transform raw data into a clean, structured data warehouse, optimized for analysis.

-   **Loading to PostgreSQL:** A script (`scripts/load_to_postgres.py`) loads the raw JSON data from the local data lake into a `raw_telegram_messages` table in a PostgreSQL database.
-   **dbt Project:** A dbt project (`telegram_analytics`) is initialized and configured to connect to the PostgreSQL database.
-   **Layered Modeling Approach:**
    -   **Staging Models:** Clean and lightly restructure the raw data (e.g., casting data types, renaming columns).
    -   **Data Mart Models:** Build final analytical tables (facts and dimensions) from the staging models, creating a star schema for easy analysis.
-   **Testing & Documentation:** dbt tests are used to ensure data quality and integrity. Project documentation is generated with `dbt docs generate`.