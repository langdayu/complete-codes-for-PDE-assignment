%% 准备初始数据

% 微分方程模型数据。函数 modeldata 返回一个结构体 pde
% pde.f : 右端项函数
% pde.exactu : 真解函数
% pde.Du ：真解导数
clear
pde = modeldata();


% 计算代表点处的真解
x = [1/4;1/2;3/4];
format long e
u = pde.exactu(x) + x;
xt = 0:0.01:1;
plot(xt,pde.exactu(xt)+xt,'-r');
hold on

% 区间
I = [0,1];

% 积分精度
option.quadOrder = 10;

% 空间维数（基函数个数）
n=1;
% Galerkin 方法求解
uh = Galerkin(pde,I,n,option);
% 显示数值解图像
showsolution(uh,':k');
% 计算代表点处的数值解
v = basis(x,n);
u_1 = v'*uh + x

%%
n=2;
uh = Galerkin(pde,I,n,option);
showsolution(uh,'-.b');
v = basis(x,n); 
u_2 = v'*uh + x

%%
n=3;
uh = Galerkin(pde,I,n,option);
showsolution(uh,'-.m');
v = basis(x,n); 
u_3 = v'*uh + x 

%%
n=4;
uh = Galerkin(pde,I,n,option);
showsolution(uh,'--c');
v = basis(x,n);
u_4 = v'*uh + x 

legend('u^*','u_1','u_2','u_3','u_4');
xlabel('X')
ylabel('Y')
u = [u'; u_1';u_2';u_3'; u_4']

%error
[nrow, ncol] = size(u);
error = zeros(nrow-1,1);
for i = 2:nrow
    error(i-1) = max(abs(u(1,:)-u(i,:)));
end

%plot(error, '*')