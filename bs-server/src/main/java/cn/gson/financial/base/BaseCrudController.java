package cn.gson.financial.base;

import cn.gson.financial.kernel.controller.JsonResult;
import cn.gson.financial.kernel.exception.ServiceException;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.lang.reflect.Field;
import java.lang.reflect.ParameterizedType;
import java.util.Map;

/**
 * <p>****************************************************************************</p>
 * <p><b>Copyright © 2010-2019 soho team All Rights Reserved<b></p>
 * <ul style="margin:15px;">
 * <li>Description : cn.gson.financial.kernel.controller</li>
 * <li>Version     : 1.0</li>
 * <li>Creation    : 2019年07月30日</li>
 * <li>@author     : ____′↘夏悸</li>
 * </ul>
 * <p>****************************************************************************</p>
 */
@Slf4j
public abstract class BaseCrudController<T extends IService, E> extends BaseController {

    @Autowired
    protected T service;

    private Class<E> entityClass;

    @ModelAttribute
    public void common(HttpServletRequest request, HttpSession session) {
        super.common(request, session);
        this.entityClass = (Class<E>) ((ParameterizedType) getClass().getGenericSuperclass()).getActualTypeArguments()[1];
    }

    /**
     * 列表数据
     *
     * @return
     */
    @GetMapping
    public JsonResult list(@RequestParam Map<String, String> params) {
        return this.getPageList(params, this.service);
    }

    /**
     * 根据 Id 获取元素
     *
     * @param id
     * @return
     */
    @GetMapping("/{id:\\d+}")
    public JsonResult load(@PathVariable Long id) {
        QueryWrapper qw = Wrappers.query();
        qw.eq("id", id);
        this.setQwAccountSetsId(qw);
        return JsonResult.successful(service.getOne(qw));
    }

    /**
     * 删除元素
     *
     * @param id
     * @return
     */
    @DeleteMapping("/{id:\\d+}")
    public JsonResult delete(@PathVariable Long id) {
        try {
            QueryWrapper qw = Wrappers.query();
            qw.eq("id", id);
            this.setQwAccountSetsId(qw);
            service.remove(qw);
            return JsonResult.successful();
        } catch (ServiceException se) {
            log.error("删除失败！", se);
            return JsonResult.failure(se.getMessage());
        } catch (Exception e) {
            log.error("删除失败！", e);
            return JsonResult.failure("删除失败！");
        }
    }

    /**
     * 创建元素
     *
     * @param entity
     * @return
     */
    @PostMapping
    public JsonResult save(@RequestBody E entity) {
        try {
            this.setEntityAccountSetsId(entity);
            service.save(entity);
            return JsonResult.successful();
        } catch (Exception e) {
            log.error("创建失败！", e);
            return JsonResult.failure(e.getMessage());
        }
    }

    /**
     * 更新元素
     *
     * @return
     */
    @PutMapping
    public JsonResult update(@RequestBody E entity) {
        this.setEntityAccountSetsId(entity);

        try {
            QueryWrapper qw = Wrappers.query();
            Field field = this.entityClass.getDeclaredField("id");
            field.setAccessible(true);
            qw.eq("id", field.get(entity));
            this.setQwAccountSetsId(qw);
            service.update(entity, qw);
            return JsonResult.successful();
        } catch (Exception e) {
            log.error("更新失败！", e);
            return JsonResult.failure(e.getMessage());
        }
    }

    /**
     * 限制数据的安全
     *
     * @param qw
     */
    protected void setQwAccountSetsId(QueryWrapper qw) {
        try {
            entityClass.getDeclaredField("accountSetsId");
            qw.eq("account_sets_id", currentUser.getAccountSetsId());
        } catch (Exception ex) {
            // 没有这个字段就不做处理了
        }
    }

    /**
     * 设置数据归属
     *
     * @param entity
     */
    protected void setEntityAccountSetsId(E entity) {
        try {
            Field field = entityClass.getDeclaredField("accountSetsId");
            field.setAccessible(true);
            field.set(entity, currentUser.getAccountSetsId());
        } catch (Exception ex) {
            // 没有这个字段就不做处理了
        }
    }

    protected final JsonResult getPageList(Map<String, String> params, IService s) {
        QueryWrapper qw = new QueryWrapper<>();
        this.setQwAccountSetsId(qw);
        JsonResult jsonResult;
        if (params.containsKey("page")) {
            Page<Map<String, String>> pageable = new Page<>(Integer.parseInt(params.get("page")), Integer.parseInt(params.getOrDefault("size", "20")));
            params.remove("page");
            params.remove("size");
            qw.allEq(params);
            jsonResult = JsonResult.successful(s.page(pageable, qw));
        } else {
            qw.allEq(params);
            jsonResult = JsonResult.successful(s.list(qw));
        }
        return jsonResult;
    }
}
