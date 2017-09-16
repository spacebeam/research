

The term identification was introduced by L.A. Zadeh [Zadeh, 1956] as a
generic expression for the problem of “determining the input-output
relationships of a black box by experimental means.”

http://users.isy.liu.se/en/rt/ljung/seoul2dvinew/plenary2.pdf
System identification is the art and science of building mathematical models of dynamic systems
from observed input-output data. It can be seen as the interface between the real world of
applications and the mathematical world of control theory and model abstractions.

System identification is a very large topic,
with different techniques that depend on the character of the models to be estimated: linear,
nonlinear, hybrid, nonparametric etc. At the same time, the area can be characterized by a
small number of leading principles, e.g. to look for sustainable descriptions by proper decisions
in the triangle of model complexity, information contents in the data, and effective validation.

System Identification is the term that has been coined
by Zadeh (1956) for the model estimation problem for
dynamic systems in the control community. 

here we focus on the prediction-error
approach, more in line with statistical time-series analysis
and econometrics. This approach and all its basic themes
were outlined in the pioneering paper Åström and Bohlin
(1965). It is also the main perspective in Ljung (1999).

ain feature of dynamical systems is that the future
depends on the past. Thus a prediction of the output y(t)
at time t, either being constructed by ad hoc reasoning or
carefully calculated in a stochastic framework, depends on
all or some previous measured inputs and outputs, Z
t−1 =
{y(t − 1), u(t − 1), y(t − 2), u(t −2), . . .}. Let us denote the
prediction by yˆ(t|t − 1) = g(Z
t−1
). In case the system is
not fully known, this prediction will be parameterized by
a parameter θ (which typically is finite-dimensional, but
could also conceptually capture nonparametric structures)
so the prediction is
yˆ(t|θ) = g(Z
t−1
, θ) (15)
The distinguishing features as well as the bulk of efforts
in System Identification can, somewhat simplistically, be
described as
(1) Invent parameterizations yˆ(t|θ), suitable to describe
linear and nonlinear dynamic systems. For underlying
state-space realizations, realization theory has been
an important source of inspiration. Questions of how
prior physical knowledge can best be incorporated
form another central issue.
(2) Translate the core material of Section 2 to properties
of estimated systems, as well as estimation procedures.
(3) Find effective ways to estimate θ numerically for the
chosen parameterizations. The curve-fitting criterion
(5) forms a beacon for these efforts in the prediction
error approach, typically leading to nonlinear optimization
by iterative search. The realization avenue
has developed techniques based on SVD and QR
factorizations.
(4) The typical intended use of the model in this context
is for prediction or control. This means that models
of the noise affecting the system often are essential.
(5) Experiment design now becomes the selection of input
signal. The effects of the experiment design can be
evaluated from the core material, but can be given
concrete interpretations in terms of model quality for
control design, e.g. Gevers (1993). Specific features for
control applications are the problems and opportunities
of using inputs, partly formed from output feedback,
e.g. Hjalmarsson (2005). An important problem
is to quantify the model error, and its contribution
from the variance error and the bias error, cf. (11),
“model error models”, e.g. Goodwin et al. (1992).