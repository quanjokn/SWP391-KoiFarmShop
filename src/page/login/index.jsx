import React, { useEffect } from 'react'
import '@fortawesome/fontawesome-free/css/all.min.css';
import styles from './login.module.css';
import { useNavigate } from 'react-router-dom'; // Nhập useNavigate

export const LoginForm = () => {
    useEffect(() => {
        document.body.style.backgroundImage = "url('/imagines/background/Koi.jpg')";
        document.body.style.backgroundSize = "cover";
        document.body.style.backgroundPosition = "center";

        // Khôi phục background khi rời khỏi trang
        return () => {
            document.body.style.backgroundImage = ""; // Hoặc thiết lập lại theo mặc định
        };
    }, []);

    const navigate = useNavigate(); // Khởi tạo useNavigate

    const handleGoogleLogin = () => {
        // Xử lý đăng nhập bằng Google ở đây
        console.log("Đăng nhập bằng Google");
    };

    const handleFacebookLogin = () => {
        // Xử lý đăng nhập bằng Facebook ở đây
        console.log("Đăng nhập bằng Facebook");
    };

    const handleLogin = async (e) => {
        e.preventDefault(); // Ngăn chặn reload trang khi submit form

        const username = e.target.username.value; // Tên đăng nhập
        const pass = e.target.pass.value; // Mật khẩu

        const loginValues = { username, pass }; // Tạo object chứa thông tin đăng nhập

        console.log(loginValues);

        // try {
        //     // Gửi req đến server
        //     const response = await api.post('login', values);
        //     console.log(response);
        //     // Xử lý phản hồi từ server ở đây (ví dụ: lưu token, chuyển hướng, thông báo...)
        // } catch (error) {
        //     console.error('Đăng nhập không thành công:', error); // Xử lý lỗi nếu có
        // }
    };

    return (
        <>
            <div className={styles.wrapper}> {/* Sửa ở đây */}
                <form onSubmit={handleLogin}>
                    <h1>Đăng nhập</h1>
                    <div className={styles['input-box']}>
                        <input name='username' type='text' placeholder='Tên đăng nhập' required />
                    </div>
                    <div className={styles['input-box']}>
                        <input name='pass' type='password' placeholder='Mật khẩu' required />
                    </div>
                    <div className={styles['remmember-forgot']}>
                        <label><input type='checkbox' />Lưu tài khoản</label>
                        <a href="" onClick={() => navigate('/forgot-password')}>Quên mật khẩu</a>
                    </div>

                    <button type='submit'>Đăng nhập</button>

                    <div className={styles.socialLogin}>
                        <a href="#" className={styles.btnFace} onClick={handleFacebookLogin}>
                            <i className="fab fa-facebook"></i>
                            Facebook
                        </a>
                        <a href="#" className={styles.btnGoogle} onClick={handleGoogleLogin}>
                            <img src="/imagines/icon/icon-google.png" alt="GOOGLE" />
                            Google
                        </a>
                    </div>

                    <div className={styles['register-link']}>
                        <p>Không có tài khoản ? <a href='' onClick={() => navigate('/register')}>Đăng kí ngay</a></p>
                    </div>
                </form>
            </div>
        </>
    );
};

export default LoginForm;
