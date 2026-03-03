from fastapi import APIRouter

router = APIRouter()

@router.get("/info")
def get_info():
    return {
        "status": "online",
        "message": "Welcome to the FastAPI Microservice",
        "features": ["CI/CD", "Docker", "AWS Fargate"]
    }

@router.get("/health")
def health_check():
    return {"status": "healthy"}