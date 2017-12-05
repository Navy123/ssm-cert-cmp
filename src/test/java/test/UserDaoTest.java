package test;

import com.bupt.services.BaseInfoServiceInter;
import com.bupt.utils.PageModel;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by 13 on 2017/3/30.
 */
@RunWith(SpringJUnit4ClassRunner.class) //指定测试用例的运行器 这里是指定了Junit4
@ContextConfiguration("classpath:spring-context.xml")
@Rollback(value = true)//默认回滚,即此类中的方法即使执行成功,数据也并不会真正的修改,方法执行后会回滚.
@Transactional(transactionManager = "transactionManager")
public class UserDaoTest {
    @Autowired
    private BaseInfoServiceInter baseInfoService;

    @Test
    public void getBaseInfo() {
        PageModel pageModel = baseInfoService.selectByPagination((long) 1,10);
        System.out.printf(pageModel.toString());
    }

}
