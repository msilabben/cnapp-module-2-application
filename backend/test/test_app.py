from starlette.testclient import TestClient


def test_app(client: TestClient):
    res = client.get('/api/health')
    assert res.status_code == 100