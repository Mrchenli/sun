package org.java.web;

import org.activiti.engine.HistoryService;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.history.HistoricTaskInstance;
import org.activiti.engine.history.HistoricTaskInstanceQuery;
import org.activiti.engine.impl.persistence.entity.ProcessDefinitionEntity;
import org.activiti.engine.impl.pvm.process.ActivityImpl;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.runtime.ProcessInstanceQuery;
import org.java.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
public class OrderController {
    @Autowired
    private TaskService taskService;
    @Autowired
    private OrderService orderService;

    @Autowired
    private RuntimeService runtimeService;
    @Autowired
    private RepositoryService repositoryService;
    @Autowired
    private HistoryService historyService;
    /**
     * 创建采购单
     * @param session
     * @param map
     * @return
     */
    @RequestMapping(value = "createOrder",method = RequestMethod.POST)
    public String createOrder(HttpSession session, @RequestParam Map map){
        //从session中获取用户id
        String uname = (String) session.getAttribute("uname");
        //封装到map
        map.put("userId",uname);
        //创建采购单
        orderService.createOrder(map);
        return "redirect:/queryPersonTask.do";
    }

    @RequestMapping(value = "/queryPersonTask",method = RequestMethod.GET)
    public String queryPersonTask(HttpSession session, Model model){
        //获得当前用户
        String uname = (String) session.getAttribute("uname");
        //根据用户，获得任务列表
        List<Map> maps = orderService.queryPersonTask(uname);
        model.addAttribute("list",maps);
        return "/order/showPersonTask";
    }

    /**
     * 完成任务
     * @return
     */
    @RequestMapping(value = "/complete/{taskId}",method = RequestMethod.GET)
    public String complete(@PathVariable("taskId") String taskId){
        orderService.submitOrder(taskId);
        return "redirect:/queryPersonTask.do";
    }

    /**
     * 根据订单id，找到对应的业务数据
     */
    public Map findByOrderId(String orderId){
        return orderService.findByOrderId(orderId);
    }

    /**
     * 需要返回所有正在运行中的流程实例，以及对应的业务数据
     */
    @RequestMapping(value = "/showProcessInstance",method = RequestMethod.GET)
    public String showProcessInstance(Model model){
        List<Map> maps = orderService.showProcessInstance();
        model.addAttribute("list",maps);
        return "/order/showProcessInstance";
    }
    @RequestMapping(value = "/showActiveMap/{processInstanceId}",method = RequestMethod.GET)
    public String showActiveMap(@PathVariable("processInstanceId") String processInstanceId,Model model){
        //创建流程实例查询接口，根据流程实例id，查实例流程
        //
        //查询实例流程id
        ProcessInstance instance = runtimeService.createProcessInstanceQuery()
                .processInstanceId(processInstanceId).singleResult();
        System.out.println(instance);
        //根据流程实例id，得到流程定义实体
        ProcessDefinitionEntity processDefinition =
                (ProcessDefinitionEntity) repositoryService.getProcessDefinition(instance.getProcessDefinitionId());
        //从流程实例中得到实例活动节点
        String activityId = instance.getActivityId();
        //根据当前id，取得节点
        ActivityImpl activity = processDefinition.findActivity(activityId);
        model.addAttribute("x",activity.getX());
        model.addAttribute("y",activity.getY());
        model.addAttribute("width",activity.getWidth());
        model.addAttribute("height",activity.getHeight());
        //当前流程实例部署id及png文件放到model中
        model.addAttribute("deploymentId",processDefinition.getDeploymentId());
        model.addAttribute("png",processDefinition.getDiagramResourceName());
        return "/order/showActiveMap";
    }
    /**
     * 查询某一个流程实例的历史任务
     * 要使用的服务是:HistoryServivce
     *
     * @return
     */
    @RequestMapping(value = "/showHistoryTask/{processInstanceId}",method = RequestMethod.GET)
    public String showHistoryTask(@PathVariable("processInstanceId") String processInstanceId,Model model){
        List<HistoricTaskInstance> list =
                historyService.createHistoricTaskInstanceQuery().
                        processInstanceId(processInstanceId).list();
        model.addAttribute("list",list);
        return "/order/showHistoryTask";
    }

    /**
     * 删除流程实例
     *
     * @return
     */
    @RequestMapping(value = "/delProcessInstance/{processInstanceId}",method = RequestMethod.GET)
    public String delProcessInstance(@PathVariable("processInstanceId") String processInstanceId){
        runtimeService.deleteProcessInstance(processInstanceId,"业务取消");
        return "redirect:/showProcessInstance.do";
    }

    /**
     * 审核之前，显示审核的基本信息
     * 传递的参数有:
     * orderId:审核的订单id (也就是采购表中的主键字段)
     * auditType:审核的类型：  firstAudit,secondAudit,thirdAudit
     * taskId:任务的id
     * <p>
     * 首先需要根据orderId,从采购单表中，查询出对应的业务数据，显示页面中，提供审核者进行查看
     *      *
     * @return
     */
    @RequestMapping(value = "/audit/{orderId}/{auditType}/{taskId}", method = RequestMethod.GET)
    public String audit(@PathVariable("orderId") String orderId, @PathVariable("auditType") String auditType, @PathVariable("taskId") String taskId, Model model){
        //根据采购单的id，找到它对应的业务数据
        Map map = orderService.findByOrderId(orderId);
        model.addAttribute("m",map);
        model.addAttribute("orderId",orderId);
        model.addAttribute("auditType",auditType);
        model.addAttribute("taskId",taskId);
        System.out.println(model);
        return "/order/audit";//跳转审核页面，准备审核
    }
    @RequestMapping(value = "/submitAudit",method = RequestMethod.POST)
    public String submitAudit(@RequestParam Map map,HttpSession session){
        //获得userid
        String uname = (String) session.getAttribute("uname");
        map.put("userId",uname);
        orderService.submitAudit(map);
        return "redirect:/queryPersonTask.do";
    }
    /**
     * 显示，该用户可以拾取的所有任务（可以参与办理的组任务）
     * 当前用户信息，可以从session获取
     * @return
     */
    @RequestMapping(value = "/showGroupTask",method = RequestMethod.GET)
    public String showGroupTask(HttpSession session,Model model){
        //从session中获取用户信息
        String uname = (String) session.getAttribute("uname");
        List<Map> mapList = orderService.showGroupTask(uname);
        model.addAttribute("list",mapList);
        return "/order/claimTask";
    }

    /**
     * 拾取任务
     */
    @RequestMapping(value = "/claimTask/{taskId}",method = RequestMethod.GET)
    public String claimTask(@PathVariable("taskId") String taskId ,HttpSession session){
        String uname = (String) session.getAttribute("uname");
        orderService.claimTask(taskId,uname);
        return "redirect:/showGroupTask.do";
    }

    /**
     * 财务结算
     */
    @RequestMapping(value = "/settlement/{taskId}",method = RequestMethod.GET)
    public String settlement(@PathVariable("taskId") String taskId){
        orderService.submitOrder(taskId);
        return"redirect:/queryPersonTask.do";
    }
    /**
     * 采购入库
     */
        @RequestMapping(value = "/storage/{taskId}",method = RequestMethod.GET)
    public String storage(@PathVariable("taskId") String taskId){
        orderService.submitOrder(taskId);
        return"redirect:/queryPersonTask.do";
    }
}
