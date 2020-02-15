package org.java.web;

import org.activiti.engine.RepositoryService;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.repository.ProcessDefinitionQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

@Controller
public class ProcessDefiinitionController {
    @Autowired
    private RepositoryService repositoryService;

    @RequestMapping(value = "/deploy",method = RequestMethod.POST)
    public String deployProcessDefinition(@RequestParam("bpmn")CommonsMultipartFile bpmn,@RequestParam("png") CommonsMultipartFile png){
        //获得bpmn,png的文件名
        String bpmnName = bpmn.getOriginalFilename();
        String pngName = png.getOriginalFilename();

        //把bpmn,png加载到输入流中
        InputStream bpmlIn = null;
        InputStream pngIn = null;
        try {
            bpmlIn = bpmn.getInputStream();
            pngIn = png.getInputStream();
        } catch (IOException e) {
            e.printStackTrace();
        }

        repositoryService.createDeployment().addInputStream(bpmnName,bpmlIn).addInputStream(pngName,pngIn).deploy();

        return "redirect:/showProcessDefinition.do";
    }

    /**
     * 显示所有流程定义
     * @param model
     * @return
     */
    @RequestMapping(value = "/showProcessDefinition",method = RequestMethod.GET)
    public String showProcessDefinition(Model model){
        ProcessDefinitionQuery processDefinitionQuery = repositoryService.createProcessDefinitionQuery();
        List<ProcessDefinition> list = processDefinitionQuery.list();
        model.addAttribute("list",list);
        return "flow/showProcessDefintion";
    }

    /**
     * 显示数据库资源
     * 传递两个参数
     * deploymentId：部署id
     * resourcesName：资源名称
     * 使用服务：repositoryService
     */
    @RequestMapping("/showResources/{deploymentId}/{resourcesName}")
    public void showResources(HttpServletResponse response , @PathVariable("deploymentId") String deploymentId, @PathVariable("resourcesName") String resourcesName){
        //通过repositoryService查询数据库，得到输入流
        InputStream resourceAsStream = repositoryService.getResourceAsStream(deploymentId,resourcesName);
        //将输入流的信息，显示在客户端浏览器中
        byte[] bytes = new byte[8192];
        int len = 0;
        //得到输出流，用于向客户浏览器，输出 内容
        ServletOutputStream outputStream = null;
        try {
            outputStream = response.getOutputStream();
            while ((len = resourceAsStream.read(bytes,0,8102))!=-1){
                outputStream.write(bytes,0,len);
            }
            outputStream.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @RequestMapping(value = "/del/{deploymentId}",method = RequestMethod.GET)
    public String delProcessDefinition(@PathVariable("deploymentId") String deploymentId){
        //删除流程
        repositoryService.deleteDeployment(deploymentId,true);
        //重定向，
        return "redirect:/showProcessDefinition.do";
    }


}
