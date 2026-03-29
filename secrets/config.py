# Secrets scanner testing fixtures - Python config with hardcoded secrets

import os

# AWS credentials removed - using environment variables
AWS_ACCESS_KEY_ID = os.environ.get("AWS_ACCESS_KEY_ID", "")
AWS_SECRET_ACCESS_KEY = os.environ.get("AWS_SECRET_ACCESS_KEY", "")
AWS_DEFAULT_REGION = "us-east-1"

# Database connection strings with embedded passwords
DATABASE_URL = "postgresql://admin:SuperSecretPassword123@db.example.com:5432/production"
MONGODB_URI = "mongodb://root:MongoDBPass456@mongo.example.com:27017/admin"
REDIS_URL = "redis://:RedisPassword789@redis.example.com:6379/0"

# API keys and tokens
GITHUB_TOKEN = "ghp_ABCDEFGHIJKLMNOPQRSTUVWXYZabcdef12"
SLACK_WEBHOOK_URL = "https://hooks.slack.com/services/T00000000/B00000000/XXXXXXXXXXXXXXXXXXXXXXXX"
SENDGRID_API_KEY = "SG.XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
STRIPE_SECRET_KEY = "sk_live_4eC39HqLyjWDarjtT1zdp7dc"

# Private key (should be detected)
PRIVATE_KEY = """-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEA0Z3VS5JJcds3xfn/ygWyF8PbnGy0AHB7MhgHcTz6sE2I2yPB
aFDrBz9vFqU4yBBTnFbHBSjyWBOq0PP8CRFh1VOkJFOqFCPBPbZGIGlRMFCOC3YM
ExampleKeyDataHereNotARealKeyButLongEnoughToTriggerDetection1234567890
ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz012345
-----END RSA PRIVATE KEY-----"""

# JWT secret
JWT_SECRET = "my-super-secret-jwt-signing-key-that-should-not-be-hardcoded"

# Encryption key
ENCRYPTION_KEY = "aes-256-cbc-key-1234567890abcdef1234567890abcdef"


def get_config():
    return {
        "aws_key": AWS_ACCESS_KEY_ID,
        "aws_secret": AWS_SECRET_ACCESS_KEY,
        "db_url": DATABASE_URL,
    }
