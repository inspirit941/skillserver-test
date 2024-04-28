import uvicorn
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from app.controller.router import api_router

app = FastAPI(
    title="glide-api",
    description="glide-api",
    root_path="",
    docs_url="/docs",
    openapi_url="/docs/openapi.json",
)

origins = ["*"]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=False,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(api_router)

if __name__=="__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)