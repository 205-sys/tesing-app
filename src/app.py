from flask import Flask, jsonify
import os

def create_app():
    app = Flask(__name__)

    @app.route("/")
    def home():
        return jsonify({
            "message": "Hello from CI/CD Demo",
            "env": os.getenv("ENV", "production")
        })

    @app.route("/health")
    def health():
        return {"status": "healthy"}, 200

    return app

app = create_app()

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
