from fastapi import APIRouter, Request


api_router = APIRouter()

@api_router.get("/health")
def health_check():
    return {"status": 200, "msg": "alive"}

@api_router.post("/mirror")
async def mirror_response(request: dict):
    result = {
        "version": "2.0",
        "template": {
            "outputs": [
                {
                    "simpleText": {
                        "text": str(request)
                    }
                }
            ]
        }
    }
    return result
