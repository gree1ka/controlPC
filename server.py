from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from workLogic import *


app = FastAPI()

class ProcessRequest(BaseModel):
    process_name: str

@app.get("/helloworld")
async def read_root():
    return {"message": "Hello, world!"}

@app.post("/launch_game")
async def launch_process(request: ProcessRequest):
    process_name = request.process_name
    try:
        launch_steam_game(process_name)
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Failed to start process: {e}")

@app.post("/launch_application")
async def launch_application_route(request: ProcessRequest):
    process_name = request.process_name
    print(process_name)
    try:
        launch_application(process_name)
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Failed to start application: {e}")
    
@app.post("/terminate")
async def terminate_process(request: ProcessRequest):
    process_name = request.process_name
    try:
        kill_task(process_name)
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Failed to terminate process: {e}")

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="192.168.1.125", port=8000)