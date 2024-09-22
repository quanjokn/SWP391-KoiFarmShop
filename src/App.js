import { createBrowserRouter, RouterProvider } from 'react-router-dom';
import '@fortawesome/fontawesome-free/css/all.min.css';
import './App.css';
import LoginForm from './page/login';
import RegisterForm from './page/register';
import Home from './page/home';
import Blog from './page/blog';
import BlogDetail from './page/blog detail';
import ForgotPassword from './page/forgot';
function App() {
  const router = createBrowserRouter([
    {
      path: "/",
      element: <Home />,  // Trang chủ
    },
    {
      path: "login",
      element: <LoginForm />,  // Trang đăng nhập
    },
    {
      path: "register",
      element: <RegisterForm />,  // Trang đăng kí
    },
    {
      path: "blog",
      element: <Blog />,  // Trang đăng kí
    },
    {
      path: "title",
      element: <BlogDetail />,  // Trang đăng kí
    },
    {
      path: '/forgot-password',
      element: <ForgotPassword />
    },
  ]);

  return <RouterProvider router={router} />;
}


export default App;
