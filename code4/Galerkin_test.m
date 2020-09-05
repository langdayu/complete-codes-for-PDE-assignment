%% ׼����ʼ����

% ΢�ַ���ģ�����ݡ����� modeldata ����һ���ṹ�� pde
% pde.f : �Ҷ����
% pde.exactu : ��⺯��
% pde.Du ����⵼��
clear
pde = modeldata();


% �������㴦�����
x = [1/4;1/2;3/4];
format long e
u = pde.exactu(x) + x;
xt = 0:0.01:1;
plot(xt,pde.exactu(xt)+xt,'-r');
hold on

% ����
I = [0,1];

% ���־���
option.quadOrder = 10;

% �ռ�ά����������������
n=1;
% Galerkin �������
uh = Galerkin(pde,I,n,option);
% ��ʾ��ֵ��ͼ��
showsolution(uh,':k');
% �������㴦����ֵ��
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