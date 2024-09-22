import loginStyles from './login.module.css';
import blogStyles from './blog.module.css';

function Layout({ children, pageType }) {
    const isLogin = pageType === 'login';

    return (
        <div className={isLogin ? loginStyles.wrapper : blogStyles.wrapper}>
            {children}
        </div>
    );
}
export default Layout;