<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Đăng Nhập</title>
  <link rel="icon" href="icon.png" type="image/png" />
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #FFD100;
      margin: 0;
      padding: 0;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
    }

    .login-box {
      background-color: white;
      padding: 30px;
      border-radius: 12px;
      box-shadow: 0 0 20px rgba(0, 0, 0, 0.2);
      text-align: center;
      width: 360px;
    }

    .login-box img {
      width: 80px;
      margin-bottom: 10px;
    }

    .login-box h2 {
      color: #0057B8;
      margin-bottom: 20px;
    }

    .login-box input {
      width: 100%;
      padding: 12px;
      margin: 10px 0;
      border: 1px solid #ccc;
      border-radius: 8px;
      font-size: 16px;
    }

    .login-box button {
      width: 100%;
      padding: 12px;
      background-color: #0057B8;
      color: white;
      font-size: 16px;
      border: none;
      border-radius: 8px;
      cursor: pointer;
      transition: background-color 0.2s ease;
    }

    .login-box button:hover {
      background-color: #003A70;
    }
  </style>
</head>
<body>
  <div class="login-box">
    <img src="icon.png" alt="Logo" />
    <h2>Đăng Nhập Hệ Thống</h2>
    <input type="email" id="email" placeholder="Email" required />
    <input type="password" id="password" placeholder="Mật khẩu" required />
    <button onclick="login()">Đăng Nhập</button>
  </div>

  <script type="module">
    import { initializeApp } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-app.js";
    import { getAuth, signInWithEmailAndPassword } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-auth.js";
    import { getFirestore, collection, getDocs, query, where } from "https://www.gstatic.com/firebasejs/10.8.0/firebase-firestore.js";

    const firebaseConfig = {
      apiKey: "AIzaSyDuTvBn8Xl01DYddVXQ7M0L24K3l-GyG0c",
      authDomain: "enactusftuhanoi-tracuu.firebaseapp.com",
      projectId: "enactusftuhanoi-tracuu",
      storageBucket: "enactusftuhanoi-tracuu.firebasestorage.app",
      messagingSenderId: "611356979403",
      appId: "1:611356979403:web:2c9a4cffb2b323ce3deb4e"
    };

    const app = initializeApp(firebaseConfig);
    const auth = getAuth(app);
    const db = getFirestore(app);

    window.login = async function () {
      const email = document.getElementById("email").value;
      const password = document.getElementById("password").value;

      try {
        // Đăng nhập bằng Firebase Authentication
        const userCredential = await signInWithEmailAndPassword(auth, email, password);
        const user = userCredential.user;

        // Kiểm tra người dùng có tồn tại trong bảng "employees"
        const q = query(collection(db, "employees"), where("email", "==", email));
        const querySnapshot = await getDocs(q);

        if (!querySnapshot.empty) {
          window.location.href = "member.html";  // Chuyển đến trang member nếu người dùng là thành viên
        } else {
          window.location.href = "admin.html";  // Nếu là admin, chuyển đến admin page
        }
      } catch (error) {
        alert("Đăng nhập thất bại: " + error.message);  // Hiển thị lỗi nếu đăng nhập thất bại
      }
    };
  </script>
</body>
</html>
