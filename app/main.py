from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def read_root():
    return {"message": "DevOps Pipeline Active", "version": "1.0.0"}

@app.get("/health")
def health_check():
    return {"status": "healthy"}