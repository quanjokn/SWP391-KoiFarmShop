import React from 'react';
import styles from './styles.module.css';
import { useNavigate } from 'react-router-dom'; // Thêm dòng này

const HeaderForm = () => {
    const navigate = useNavigate(); // Khởi tạo useNavigate

    return (
        // Page Header
        <header className={`${styles.masthead}`} style={{ backgroundImage: "url('imagines/background/KoiFish.jpg')" }}>
            <div className={`container position-relative px-4 px-lg-5`}>
                <div className="row gx-4 gx-lg-5 justify-content-center">
                    <div className="col-md-10 col-lg-8 col-xl-7">
                        <div className={`${styles.siteHeading}`}>
                            <h1>Tin tức</h1>
                        </div>
                    </div>
                </div>
            </div>
        </header>

    );
};

export default HeaderForm;