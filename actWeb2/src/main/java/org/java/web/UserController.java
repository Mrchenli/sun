package org.java.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpSession;
@Controller
public class UserController {
    @RequestMapping(value = "/login",method = RequestMethod.POST)
    public String login(String uname , HttpSession ses){
        ses.setAttribute("uname",uname);
        return "/main";
    }


    @RequestMapping(value = "/logout",method = RequestMethod.GET)
    public String queryPersonTask(HttpSession session){
        //获得当前用户
        String uname = (String)session.getAttribute("uname");
        return "redirect:/index.jsp";
    }
}
