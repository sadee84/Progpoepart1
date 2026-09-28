name: Validate Part 1 Documentation

on:
  push:
    branches:
      - part1
  pull_request:
    branches:
      - part1

jobs:
  validate-docs:
    name: Check Required Documentation Files
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v3

      - name: Check docs folder exists
        run: |
          if [ ! -d "docs" ]; then
            echo "ERROR: docs folder is missing!"
            exit 1
          else
            echo "docs folder found"
          fi

      - name: Check docs/diagrams folder exists
        run: |
          if [ ! -d "docs/diagrams" ]; then
            echo "ERROR: docs/diagrams folder is missing!"
            exit 1
          else
            echo "docs/diagrams folder found"
          fi

      - name: Check ERD PDF exists
        run: |
          if ! ls docs/diagrams/*.pdf 1> /dev/null 2>&1; then
            echo "ERROR: No ERD PDF found in docs/diagrams/"
            exit 1
          else
            echo "ERD PDF found"
          fi

      - name: Check docs/sql folder exists
        run: |
          if [ ! -d "docs/sql" ]; then
            echo "ERROR: docs/sql folder is missing!"
            exit 1
          else
            echo "docs/sql folder found"
          fi

      - name: Check SQL script exists
        run: |
          if [ ! -f "docs/sql/RaceDay_DB.sql" ]; then
            echo "ERROR: SQL script is missing!"
            exit 1
          else
            echo "SQL script found"
          fi

      - name: Check docs/api-plan folder exists
        run: |
          if [ ! -d "docs/api-plan" ]; then
            echo "ERROR: docs/api-plan folder is missing!"
            exit 1
          else
            echo "docs/api-plan folder found"
          fi

      - name: Check API endpoint plan exists
        run: |
          if [ ! -f "docs/api-plan/api-endpoints.md" ] && ! ls docs/api-plan/*.pdf 1> /dev/null 2>&1; then
            echo "ERROR: API endpoint plan is missing!"
            exit 1
          else
            echo "API endpoint plan found"
          fi

      - name: Check README exists
        run: |
          if [ ! -f "README.md" ]; then
            echo "ERROR: README.md is missing!"
            exit 1
          else
            echo "README.md found"
          fi

      - name: All checks passed
        run: |
          echo "All required Part 1 documentation is present!"
