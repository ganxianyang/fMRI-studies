
import numpy as np
import pandas as pd
import matplotlib as mpl
import matplotlib.pyplot as plt
import seaborn as sns
import warnings; warnings.filterwarnings(action='once')

large = 22; med = 16; small = 12
params = {'axes.titlesize': large,
          'legend.fontsize': med,
          'figure.figsize': (16, 10),
          'axes.labelsize': med,
          'axes.titlesize': med,
          'xtick.labelsize': med,
          'ytick.labelsize': med,
          'figure.titlesize': large}
plt.rcParams.update(params)
plt.style.use('seaborn-whitegrid')
sns.set_style("white")
# %matplotlib inline

# Version
print(mpl.__version__)  #> 3.0.0
print(sns.__version__)  #> 0.9.


# Prepare Data
df= pd.read_csv("functional_behavioral_decoding.CSV")

plt.rc('font',family='Times New Roman') 

# Draw plot
import matplotlib.patches as patches

fig, ax = plt.subplots(figsize=(16,10), facecolor='white', dpi= 80)
ax.vlines(x=df.index, ymin=0, ymax=df.cty, color='#d9d9d9', alpha=0.7, linewidth=20)
ax.vlines(x=df.index[1], ymin=0, ymax=8.89, color='firebrick', alpha=0.7, linewidth=20)
ax.vlines(x=df.index[7], ymin=0, ymax=6.58, color='firebrick', alpha=0.7, linewidth=20)
ax.vlines(x=df.index[15], ymin=0, ymax=7.87, color='firebrick', alpha=0.7, linewidth=20)
ax.vlines(x=df.index[24], ymin=0, ymax=7.4, color='firebrick', alpha=0.7, linewidth=20)
ax.vlines(x=df.index[34], ymin=0, ymax=4.23, color='firebrick', alpha=0.7, linewidth=20)
ax.vlines(x=df.index[41], ymin=0, ymax=3.51, color='firebrick', alpha=0.7, linewidth=20)


# Annotate Text
for i, cty in enumerate(df.cty):
    ax.text(i, cty+0.5, round(cty, 2), horizontalalignment='center',fontsize=12.5)


# Title, Label, Ticks and Ylim
ax.set(ylabel='Activation likelihood ratio', ylim=(0, 12))
plt.xticks(df.index, df.manufacturer, rotation=85, horizontalalignment='right', ha="center",fontproperties='Times New Roman',fontsize=16) 
plt.yticks(size=16)
plt.ylabel('Activation likelihood ratio',fontsize=20)

# Add patches to color the X axis labels                  
p1 = patches.Rectangle((.125, 0.085), width=.1322, height=.115, alpha=.3, facecolor='#8dd3c7', transform=fig.transFigure)
p2 = patches.Rectangle((.2572, 0.085), width=.093, height=.115, alpha=.3, facecolor='#ffffb3', transform=fig.transFigure)
p3 = patches.Rectangle((.3502, 0.085), width=.0144, height=.115, alpha=.3, facecolor='#bebada', transform=fig.transFigure)
p4 = patches.Rectangle((.3646, 0.085), width=.108, height=.115, alpha=.3, facecolor='#fb8072', transform=fig.transFigure)
p5 = patches.Rectangle((.4726, 0.085), width=.045, height=.115, alpha=.3, facecolor='#80b1d3', transform=fig.transFigure)
p6 = patches.Rectangle((.5176, 0.085), width=.046, height=.115, alpha=.3, facecolor='#fdb462', transform=fig.transFigure)
p7 = patches.Rectangle((.5636, 0.085), width=.046, height=.115, alpha=.3, facecolor='#b3de69', transform=fig.transFigure)
p8 = patches.Rectangle((.6096, 0.085), width=.107, height=.115, alpha=.3, facecolor='#fccde5', transform=fig.transFigure)
p9 = patches.Rectangle((.7166, 0.085), width=.0307, height=.115, alpha=.3, facecolor='#969696', transform=fig.transFigure)
p10 = patches.Rectangle((.7470, 0.085), width=.153, height=.115, alpha=.3, facecolor='#bc80bd', transform=fig.transFigure)
                  
fig.add_artist(p1)
fig.add_artist(p2)
fig.add_artist(p3)
fig.add_artist(p4)
fig.add_artist(p5)
fig.add_artist(p6)
fig.add_artist(p7)
fig.add_artist(p8)
fig.add_artist(p9)
fig.add_artist(p10)

sns.despine() 
plt.subplots_adjust(bottom=0.2) 

ax=plt.gca(); 
ax.spines['bottom'].set_linewidth(2); 
ax.spines['left'].set_linewidth(2); 

plt.show()