from src.app import create_app

def test_home():
    app = create_app()
    client = app.test_client()
    res = client.get("/")
    assert res.status_code == 200

def test_health():
    app = create_app()
    client = app.test_client()
    res = client.get("/health")
    assert res.json["status"] == "healthy"
