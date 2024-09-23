import React from 'react';
import styles from './tagbar.module.css';
import { useNavigate } from 'react-router-dom'; // Thêm dòng này

const Tagbar = () => {
    const navigate = useNavigate(); // Khởi tạo useNavigate

    return (
        <>
            <div className={styles.tagbar}>
                <nav>
                    <ul className={styles.navList}>
                        <li><a href="/">Trang chủ</a></li>
                        <li><a href="/san-pham">Sản phẩm</a></li>
                        <li><a href="/giong-ca">Giống cá</a></li>
                        <li><a href="/tin-tuc">Tin tức</a></li>
                        <li><a href="/lien-he">Liên hệ</a></li>
                    </ul>
                </nav>
            </div>
        </>
    );
};
export default Tagbar;