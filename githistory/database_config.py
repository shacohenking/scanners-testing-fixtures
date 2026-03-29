# Database configuration - CONTAINS HARDCODED SECRETS (will be removed in next commit)

DB_HOST = "production-db.example.com"
DB_PORT = "5432"
DB_USER = "admin"
DB_PASSWORD = "SuperS3cretPr0duction!Pass#2024"
DB_NAME = "production_app"

AWS_ACCESS_KEY_ID = "AKIARPIT7QCJZ5BR553U"
AWS_SECRET_ACCESS_KEY = "DSnPnbAH1QwEu+utk4ZWO/c1KlcYT4/1AgaJ5HLXL"

PRIVATE_API_KEY = "sk_live_51HG3jK2eZvKYlo2C0EXAMPLE1234567890abcdef"

CONNECTION_STRING = f"postgresql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"
