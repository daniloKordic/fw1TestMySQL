<!DOCTYPE beans PUBLIC "-//SPRING//DTD BEAN//EN" "http://www.springframework.org/dtd/spring-beans.dtd">

<beans default-autowire="byName">

	<bean id="appSettings" autowire="no" class="fw1test.model.config">
		<property name="config">
			<map>
				<entry key="dsn"><value>${dsn}</value></entry>
			</map>
		</property>
	</bean>

	<bean id="ParentConfig" autowire="no" abstract="true">
		<constructor-arg name="settings"><ref bean="appSettings" /></constructor-arg>
	</bean>

	<bean id="userService" autowire="no" class="fw1Test.model.userService">
		<constructor-arg name="userGateway"><ref bean="userGateway"/></constructor-arg>
	</bean>
	<bean id="userGateway" autowire="no" parent="ParentConfig" class="fw1Test.model.userGateway" />

	<bean id="menuService" autowire="no" class="fw1Test.model.menuService">
		<constructor-arg name="menuGateway"><ref bean="menuGateway" /></constructor-arg>
	</bean>
	<bean id="menuGateway" autowire="no" parent="ParentConfig" class="fw1Test.model.menuGateway" />

	<bean id="productService" autowire="no" class="fw1Test.model.productService">
		<constructor-arg name="productGateway"><ref bean="productGateway"/></constructor-arg>		
	</bean>
	<bean id="productGateway" autowire="no" parent="ParentConfig" class="fw1Test.model.productGateway"/>

	<bean id="categoryService" autowire="no" class="fw1Test.model.categoryService">
		<constructor-arg name="categoryGateway"><ref bean="categoryGateway"/></constructor-arg>		
	</bean>
	<bean id="categoryGateway" autowire="no" parent="ParentConfig" class="fw1Test.model.categoryGateway"/>		

</beans>