package org.java.dao;

import org.activiti.engine.runtime.ProcessInstance;
import org.apache.ibatis.annotations.Param;

import java.util.Map;

public interface OrderMapper {
    public void createOrder(Map map);
    /**
     * 根据流程实例id，找到对应的业务数据
     */

    public Map findMapByProcessInstanceId(@Param("processInstanceId") String processInstanceId);

    /**
     * 根据订单id，找到对应的业务数据
     * @param orderId
     * @return
     */
    public Map findByOrderId(@Param("orderId") String orderId);


    public void submitAudit(Map map);

}
