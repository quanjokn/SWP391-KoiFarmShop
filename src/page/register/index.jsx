import React, { useState } from 'react';
import { useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import styles from './styles.module.css'; // Giả sử bạn có một CSS module để định kiểu

const RegisterForm = () => {
    useEffect(() => {
        document.body.style.backgroundImage = "url('/imagines/background/Koi.jpg')";
        document.body.style.backgroundSize = "cover";
        document.body.style.backgroundPosition = "center";

        // Khôi phục background khi rời khỏi trang
        return () => {
            document.body.style.backgroundImage = ""; // Hoặc thiết lập lại theo mặc định
        };
    }, []);

    const [errors, setErrors] = useState({});
    const navigate = useNavigate();

    // Logic JavaScript để xử lý việc gửi form
    const handleRegister = (e) => {
        e.preventDefault(); // Ngăn trang reload khi gửi form

        // Lấy giá trị từ các trường input
        const username = e.target.username.value;
        const password = e.target.pass.value;
        const email = e.target.email.value;
        const phoneNumber = e.target['phone-number'].value;

        // Regex để xác thực email và số điện thoại
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        const phoneRegex = /^\d{10}$/;

        const newErrors = {};

        // Xác thực định dạng email
        if (!emailRegex.test(email)) {
            newErrors.email = 'Email không hợp lệ!';
        }

        // Xác thực định dạng số điện thoại
        if (!phoneRegex.test(phoneNumber)) {
            newErrors.phoneNumber = 'Số điện thoại phải có 10 chữ số!';
        }

        // Cập nhật lỗi nếu có
        setErrors(newErrors);

        // Ngừng gửi nếu có lỗi xác thực
        if (Object.keys(newErrors).length > 0) {
            return;
        }

        // Tạo một đối tượng chứa dữ liệu đăng kí
        const registerValues = { username, password, email, phoneNumber };

        // Ghi lại giá trị đăng kí để xử lý sau
        console.log(registerValues);
        // Bạn có thể xử lý quá trình đăng kí ở đây (ví dụ: gọi API)
    };

    return (
        <div className={styles.wrapper}>
            <form onSubmit={handleRegister}>
                <h1>Đăng kí</h1>
                <div className={styles.inputBox}>
                    <input name='username' type='text' placeholder='Tên đăng nhập' required />
                </div>
                <div className={styles.inputBox}>
                    <input name='pass' type='password' placeholder='Mật khẩu' required />
                </div>
                <div className={styles.inputBox}>
                    <input name='email' type='text' placeholder='Email' required />
                    {errors.email && <p className={styles.error}>{errors.email}</p>} {/* Hiển thị lỗi email */}
                </div>
                <div className={styles.inputBox}>
                    <input name='phone-number' type='text' placeholder='Số điện thoại' required />
                    {errors.phoneNumber && <p className={styles.error}>{errors.phoneNumber}</p>} {/* Hiển thị lỗi số điện thoại */}
                </div>
                <button type='submit'>Đăng kí</button>

                <div className={styles.registerLink}>
                    <p>Đã có tài khoản? <a href='' onClick={() => navigate('/login')}>Đăng nhập ngay</a></p>
                </div>
            </form>
        </div>
    );
};

export default RegisterForm;
