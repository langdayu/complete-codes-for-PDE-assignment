function U = FD1d_bvp(N, f, a, b, u)

%*************************************************************80
%% FD1d_bvp 利用中心差分格式求解两点边值问题.
%
%  参数:
%    输入参数：
%		整数 N, 网格节点数.
%
%    		函数f( x ), 计算右端函数 f(x);
%
%    		a, 计算区间左端点
%
%    		b, 计算区间右端点
%
%		u, 真解函数
%    输出参数：
%		差分解向量U.

%
%  均匀剖分区间[a,b], 得到网格x(i)=a+(i-1)*(b-a)/(N-1)
%
  h=(b-a)/(N-1);
  x = [a:h:b]';
%
%  创建线性差分方程组系数矩阵
%
   m = 2/h/h;
   n = -1/h/h;
   d = [1, m*ones(1,N-2), 1];
   g = [n*ones(1,N-2), 0];
   c = [0, n*ones(1,N-2)];
   A = diag(g, -1)+diag(d)+diag(c,1);
%
%  创建线性差分方程组右端项
%
  rhs = zeros ( N, 1 );  
  rhs = f(x);
  rhs(1) = u(x(1));
  rhs(N) = u(x(N));
%
%  求解上述代数系统.
%
  U = zeros(N, 1);
  U = A \ rhs;
%
%  计算误差，可视化结果
%
  ue=zeros(N,1); 
  ue=u(x);

  ee=ue-U;
  e=max(abs(ue-U))
  e0=0;
  e1=0;

  e0 = h*sum(ee.^2);
  
  e1 = sum((ee(2:N)-ee(1:N-1)).^2)/h;

  e1 = e1+e0;
  sqrt(e0)
  sqrt(e1)

  plot(x, ue, '-k*', x, U, 'ro');
  axis([0 1 -1.8 1.8]);
  title('The solution plot');
  xlabel('x');  ylabel('u');
  legend('exact','finite diff');
end

