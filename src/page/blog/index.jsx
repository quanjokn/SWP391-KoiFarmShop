import React, { useEffect } from 'react';
import styles from './blog.module.css';
import Footer from '../../component/footer';


const Blog = () => {
    useEffect(() => {
        document.body.style.backgroundColor = "white"; // Màu nền cho trang chủ

        return () => {
            document.body.style.backgroundColor = ""; // Khôi phục về mặc định nếu cần
        };
    }, []);
    return (
        <>
            <header className={`${styles.masthead}`} style={{ backgroundImage: "url('imagines/background/KoiFish.jpg')" }}>
                <div className="container position-relative px-4 px-lg-5">
                    <div className="row gx-4 gx-lg-5 justify-content-center">
                        <div className="col-md-10 col-lg-8 col-xl-7">
                            <div className={`${styles.siteHeading}`}>
                                <h1>Tin tức</h1>
                            </div>
                        </div>
                    </div>
                </div>
            </header>
            <div className={styles.container + " px-4 px-lg-5"}>
                <div className="row gx-4 gx-lg-5 justify-content-center">
                    <div className="col-md-10 col-lg-8 col-xl-7">
                        {/* Post preview */}
                        <div className={styles.postPreview}>
                            <a href="title">
                                <h2 className={styles.postTitle}>
                                    Man must explore, and this is exploration at its greatest
                                </h2>
                                <h3 className={styles.postSubtitle}>
                                    Problems look mighty small from 150 miles up
                                </h3>
                            </a>
                            <p className={styles.postMeta}>
                                Đăng bởi Start Bootstrap on September 24, 2023
                            </p>
                        </div>
                        {/* Divider */}
                        <hr className="my-4" />

                        {/* Post preview */}
                        <div className={styles.postPreview}>
                            <a href="title">
                                <h2 className={styles.postTitle}>
                                    I believe every human has a finite number of heartbeats. I don't intend to waste any of mine.
                                </h2>
                            </a>
                            <p className={styles.postMeta}>
                                Đăng bởi Start Bootstrap on September 24, 2023
                            </p>
                        </div>
                        {/* Divider */}
                        <hr className="my-4" />

                        {/* Post preview */}
                        <div className={styles.postPreview}>
                            <a href="title">
                                <h2 className={styles.postTitle}>
                                    Science has not yet mastered prophecy
                                </h2>
                                <h3 className={styles.postSubtitle}>
                                    We predict too much for the next year and yet far too little for the next ten.
                                </h3>
                            </a>
                            <p className={styles.postMeta}>
                                Đăng bởi Start Bootstrap on September 24, 2023
                            </p>
                        </div>
                        {/* Divider */}
                        <hr className="my-4" />

                        {/* Post preview */}
                        <div className={styles.postPreview}>
                            <a href="title">
                                <h2 className={styles.postTitle}>Failure is not an option</h2>
                                <h3 className={styles.postSubtitle}>
                                    Many say exploration is part of our destiny, but it’s actually our duty to future generations.
                                </h3>
                            </a>
                            <p className={styles.postMeta}>
                                Đăng bởi Start Bootstrap on September 24, 2023
                            </p>
                        </div>
                        {/* Divider */}
                        <hr className="my-4" />

                        {/* Pager */}
                        <div className="d-flex justify-content-end mb-4">
                            <a className="btn btn-primary text-uppercase" href="#!">
                                Xem thêm →
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            <Footer />
        </>
    );
};

export default Blog;