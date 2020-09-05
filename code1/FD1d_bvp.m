function [x,U] = FD1d_bvp(N, f, a, b,u)

%*************************************************************80
%% FD1d_bvp 利用中心差分格式求解两点边值问题.
%
%  参数:
%    输入参数：
%		整数 N, 网格节点数.
%
%    	函数f( x ), 计算右端函数 f(x);
%
%    	a, 计算区间左端点
%
%    	b, 计算区间右端点
%
%		u, 真解函数
%    输出参数：
%		差分解向量U.

%
%  均匀剖分区间[a,b], 得到网格x(i)=a+(i-1)*(b-a)/(N-1)
%
  h=(b-a)/(N-1);
  x = (a:h:b)'; %(a:h:b)返回的是行向量，需要转置
%
%  创建线性差分方程组系数矩阵
%

   c1 = -1/h/h;
   c2 = 2/h/h + 1;
   g = [c1*ones(1,N-2), 0];
   c = [0, c1*ones(1,N-2)];
   d = [1, c2*ones(1,N-2), 1];
   A = diag(g, -1)+diag(d)+diag(c,1);
%
%  创建线性差分方程组右端项
%
  rhs = f(x);
  rhs(1) = u(x(1));
  rhs(N) = u(x(N));
%
%  求解上述代数系统.
%
  U = A \ rhs;
end

