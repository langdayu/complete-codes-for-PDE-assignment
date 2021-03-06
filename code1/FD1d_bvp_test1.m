function U = FD1d_bvp(N, f, L, R, u)

%*************************************************************80
%
%% FD1d_bvp 用来求解两点边值问题.
%
%  问题:
%
%    该程序应用有限差分方法来求解两点边值问题
%           - u''(x) = f(x), L<= x <= R.
%    其中 f(x) 为给定的已知函数，边界条件为:
%
%      u(L) = \alpha
%      u(R) = \beta
%
%    将计算区域[L,R]等距剖分，节点为 L=x(1) < x(2) < ... < x(N)=R.
%
%    我们用一个向量U=(U(1), ..., U(N))来表示解函数 U(X)
%
%     U(1) 和 U(N) 由边界条件来确定.
%
%    在每一内节点1<i<N, 我们可以利用有限差分法来得到方程，从而可以确定U(i).
%    具体的，我们利用差商来逼近u(x), 将x(i-1), x(i), x(i+1)分别记为 xl, 
%    xm, xr. 相应的有UL, UM, UR. 其他的量在x(i) = xm处的取值以M标记:
%
%    - ( UL - 2 UM + UR ) / Dx^2 = FM
%
%    上面的 N-2 线性方程构成了一个以U(2), ..., U(N-1)为未知量的线性代数系统
%    从而求解此代数系统即得边值问题的差分逼近解.
%
%  时间:
%
%    2014年1月11日
%
%  作者:
%
%    易年余
%
%  参数:
%    输入参数：
%		整数 N, 网格节点数.
%
%    		函数f( x ), 计算右端函数 f(x);
%
%    		L, 计算区间左端点
%
%    		R, 计算区间右端点
%
%		u, 真解函数
%    输出参数：
%		差分解向量U(N).
%

%
%  均匀剖分区间[L,R], 得到网格x(i)=L+(i-1)*(R-L)/(N-1)
%
  x = zeros(N,1);
  for i=1 : N	
	x(i) = L+(i-1)*(R-L)/(N-1);
  end
%
%  创建线性差分方程组系数矩阵A和右端向量b.
%
  A = zeros ( N, N );
  rhs = zeros ( N, 1 );
  U = zeros(N, 1);
%
%  第一个方程为左边界条件, U(x(1)) = \alpha;
%
  A(1,1) = 1.0;
  rhs(1) = u(x(1));
%
%  以下得到第2---N-1个方程.
%
  for i = 2 : N - 1
    xm  = x(i);
    fm  = f ( xm );

    A(i,i-1) = - 1.0 /(x(i)-x(i-1))/(x(i+1)-x(i));

    A(i,i) = 2.0 /(x(i)-x(i-1))/(x(i+1)-x(i));

    A(i,i+1) = - 1.0/(x(i+1)-x(i))/(x(i+1)-x(i));

    rhs(i)   = fm;
  end
%
%  最后一个方程为右边界条件, U(x(N)) = \beta;
%
  A(N,N) = 1.0;
  rhs(N) = u(x(N));
%
%  求解上述代数系统.
%
  U = A \ rhs;

  return
end

