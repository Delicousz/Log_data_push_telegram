from flask import Flask

app = Flask(__name__)

@app.route('/')
def home():
    return 'Selamat datang di halaman utama!'

if __name__ == '__main__':
    app.run()
