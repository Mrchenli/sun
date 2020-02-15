package org.java.service;

import java.util.List;
import java.util.Map;

public interface OrderService {
    public void createOrder(Map map);

    /**
     * 返回所有需要处理任务：包含工作流的信息，以及对应的业务数据
     * @param userId 用户名，查询的是当前用户的任务
     * @return
     */
    public List<Map> queryPersonTask(String userId);

    public void submitOrder(String taskId);

    public Map findByOrderId(String orderId);

    public List<Map> showProcessInstance();

    public void submitAudit(Map map);

    public List<Map> showGroupTask(String userId);

    public void claimTask(String taskId, String userId);
}
