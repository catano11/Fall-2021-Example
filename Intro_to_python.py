#Intro to python on October 6, 2021
import pandas as pd  #load a python library
import matplotlib.pyplot as plt
dat0 = pd.read_csv("data/sim_data.csv")
dat0
dat0.info()  
dat0.head()
dat0.describe()

dat0.sort_values('ALB')
dat0.sort_values(['ALB', 'CREA'])
dat0.sort_values(['ALB', 'CREA'],ascending = [False,True])
dat0.ALB  #subset
dat0['ALB']
dat0[['Age','ALB','CREA']]
dat0.ALB > 50
dat0[dat0.ALB > 50]
dat0.ALB.between(40, 50, inclusive=True) 
 
dat0.loc[dat0.ALB.between(40, 50, inclusive=True), 'CHOL' ]
dat0.iloc[10:30,2:5]
dat0['Ag e'] = 42
dat0.head()
dat0.eval('Age+PROT')
dat0.columns
dat0.columns[1]
dat0.iloc[1]
dat0.iloc[:, 1]

AP1=dat0.plot.scatter('ALB', 'PROT')
AP1=dat0.plot.scatter('ALB', 'PROT', c='Green')
AP1=dat0[dat0.Sex=='f'].plot.scatter('ALB', 'PROT', c='Green')
AP2=dat0[dat0.Sex=='m'].plot.scatter('ALB', 'PROT', c='Red')
AP1=dat0[dat0.Sex=='f'].plot.scatter('ALB', 'PROT', c='Green', label='f')
AP2=dat0[dat0.Sex=='m'].plot.scatter('ALB', 'PROT', c='Red', label='m',ax=AP1)
plt.show()

