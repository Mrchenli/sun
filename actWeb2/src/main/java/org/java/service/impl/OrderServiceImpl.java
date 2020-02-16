package org.java.service.impl;

import org.activiti.engine.IdentityService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.runtime.ProcessInstanceQuery;
import org.activiti.engine.task.Task;
import org.activiti.engine.task.TaskQuery;
import org.java.dao.OrderMapper;
import org.java.service.OrderService;
import org.java.util.ResourcesUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class OrderServiceImpl implements OrderService {
    @Autowired
    private OrderMapper orderMapper;
    @Autowired
    private TaskService taskService;
    @Autowired
    private RuntimeService runtimeService;
    @Autowired
    private IdentityService identityService;

    @Override
    public void createOrder(Map map) {
        //得到用户名
        String userId = map.get("userId").toString();
        //设置为发起者
        identityService.setAuthenticatedUserId(userId);
        /**启动流程实例**/
        //创建buniessKey,用于关联到业务表
        String businessKey = UUID.randomUUID().toString();
        //指定流程定义的key
        String processDefinitionKey = ResourcesUtil.getValue("/process","processDefinitionKey");

        int price = Integer.parseInt(map.get("price").toString());
        Map<String,Object> variables = new HashMap<>();
        variables.put("price",price);
        //启动流程实例
        ProcessInstance Instance = runtimeService.startProcessInstanceByKey(processDefinitionKey, businessKey,variables);

        /**向采购表添加记录**/
        map.put("id",businessKey);//业务表主键 使用uuid
        map.put("createTime",new Date());//采购单创建时间
        map.put("processInstanceId",Instance.getProcessInstanceId());//采购单所属实例ID

        //新增
        orderMapper.createOrder(map);
    }

    @Override
    public void submitOrder(String taskId) {
        taskService.complete(taskId);
    }

    /**
     *任务相关的服务是：TaskService
     * @param userId 用户名，查询的是当前用户的任务
     * @return
     */
    @Override
    public List<Map> queryPersonTask(String userId) {
        //创建任务查询接口
        TaskQuery taskQuery = taskService.createTaskQuery();
        //查询指定业务
        taskQuery.taskAssignee(userId);
        //得到任务集合
        List<Task> list = taskQuery.list();
        //创建集合包含工作流与业务数据
        List<Map> maplist = new ArrayList<>();
        //取得数据
        for (Task task: list) {
            //获得每一个任务对应的流程实例ID
            String processInstanceId = task.getProcessInstanceId();
            //根据流程实例 id，查询对应的业务数据，返回的类型是：map.
            //map中，只包含业务数据，没有工作流的信息（任务id,任务名称。。。。）
            Map map = orderMapper.findMapByProcessInstanceId(processInstanceId);
            map.put("taskId",task.getId());//任务id
            map.put("taskName",task.getName());//任务名称
            map.put("taskDef",task.getTaskDefinitionKey());//标识
            map.put("startTime",task.getCreateTime());//开始时间
            map.put("assignee",task.getAssignee());//当前负责人

            maplist.add(map);
        }
        return maplist;
    }

    @Override
    public Map findByOrderId(String orderId) {
        return orderMapper.findByOrderId(orderId);
    }

    @Override
    public List<Map> showProcessInstance() {
        //创建流程实例查询接口
        ProcessInstanceQuery query = runtimeService.createProcessInstanceQuery();
        //查询所有实例
        List<ProcessInstance> instanceList = query.list();
        List<Map> list = new ArrayList<>();
        for (ProcessInstance p:instanceList) {
            String processInstanceId = p.getProcessInstanceId();
            Map map = orderMapper.findMapByProcessInstanceId(processInstanceId);
            map.put("processInstanceId",p.getProcessInstanceId());
            map.put("processDefinition",p.getProcessDefinitionId());
            map.put("actDef",p.getActivityId());
            list.add(map);
        }
        return list;
    }

    @Override
    public void submitAudit(Map map) {
        //生成id
        String s = UUID.randomUUID().toString();
        map.put("id",s);
        map.put("createTime",new Date());

        //获得阶段审核
        String auditType = map.get("auditType").toString();
        int status = Integer.parseInt(map.get("status").toString());
        Map<String, Object> variables = new HashMap<>();
        variables.put(auditType,status);
        //提交审核意见
        orderMapper.submitAudit(map);
        //任务向后推
        String taskId = (String) map.get("taskId");
        taskService.complete(taskId,variables);
    }

    @Override
    public List<Map> showGroupTask(String userId) {
        //查询任务
        List<Task> taskList = taskService.createTaskQuery().taskCandidateUser(userId).list();
        //创建集合，得到对应的业务数据
        List<Map> list = new ArrayList<>();
        //对所有任务循环，取得每一个任务对应的业务数据
        for (Task t:taskList){
            //获得任务对应id
            String processInstanceId = t.getProcessInstanceId();
            //根据流程实例 id，查询对应的业务数据，返回的类型是：map.
            //map中，只包含业务数据，没有工作流的信息（任务id,任务名称。。。。）
            Map map = orderMapper.findMapByProcessInstanceId(processInstanceId);
            //工作流信息放入map
            map.put("taskId",t.getId());
            map.put("taskName",t.getName());
            map.put("taskDef",t.getTaskDefinitionKey());
            map.put("startTime",t.getCreateTime());
            map.put("assignee",t.getAssignee());
            list.add(map);
        }
        return list;
    }

    @Override
    public void claimTask(String taskId, String userId) {
        Task task = taskService.createTaskQuery().
                taskId(taskId).taskCandidateUser(userId).singleResult();

        if (task!=null){
            taskService.claim(taskId,userId);
        }
    }
}
