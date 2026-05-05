from importlib.metadata import version, PackageNotFoundError

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware


def get_version() -> str:
    try:
        return version("backend")
    except PackageNotFoundError:
        return "0.0.0-dev"

# Create app
def create_app():
    app = FastAPI(title="Simple FastAPI API", version=get_version())

    app.add_middleware(
        CORSMiddleware,
        allow_origins=["*"],
        allow_credentials=True,
        allow_methods=["*"],
        allow_headers=["*"],
    )


    @app.get("/api/health")
    def health_check():
        return {"status": "ok"}

    @app.get("/api/version")
    def api_version():
        return {"version": get_version()}


    @app.get("/api/message")
    def get_message():
        return {
            "message": "Hello from FastAPI!",
            "deployment": "This backend is container-friendly and ready for Codespaces."
        }

    return app