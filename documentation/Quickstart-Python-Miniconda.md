# Quickstart:  Miniconda for PhysiCell

## Python

PhysiCell uses Python in a few different ways:
1) It is needed to install certain libraries for the intracellular models.
2) It can be used for visualization and data analysis scripts.
3) It can be used for parameter explorations of models.

We highly recommend installing the freely available Anaconda Python distribution. 
However, if you are already actively using Python from another distribution, you may run into possible problems by installing another one. 
In that case, you may want to reach out to the PhysiCell community for help (see below).

To install the Anaconda Python, you have two options:

1) download/install the entire [Individual Edition](https://www.anaconda.com/products/individual). Be warned: this is ~400-500MB in size because it contains a very large suite of modules. But if you have plenty of free disk space, we recommend it.

If you choose this option, during the installation process, select the option to add Anaconda to your PATH, in spite of the "Not recommended" comment:

![anaconda_to_path](images/anaconda_add_to_path_med.png)

2) download/install a much smaller distribution called [Miniconda](https://docs.conda.io/en/latest/miniconda.html). Download the latest 3.x version (for MacOS, we recommend installing the "bash" version instead of the "pkg"). Then install the minimal modules needed by PhysiCell:
    
```
    $ conda install -c conda-forge matplotlib
    $ conda install -c conda-forge scipy
    $ conda install -c conda-forge pyqt
```
And if you plan to create nanoHUB apps from a PhysiCell project, you may want to preview the Jupyter notebook, in which case you would need:
    
```
    $ conda install -c conda-forge notebook
    $ conda install -c conda-forge ipywidgets
    $ conda install -c conda-forge nb_conda_kernels
```

Regardless of which option you choose - full Anaconda or Miniconda, you will also need to install an additional 3rd-party
module that will be used by the Jupyter notebook apps:

```
    $ pip install -U hublib  # has some Windows issues 
```

After installation, you should be able to open a new shell (Powershell, Command Prompt, Terminal) and type `python` to verify that it is using the Anaconda one, e.g.:
```
~$ python
Python 3.9.1 (default, Dec 11 2020, 06:28:49) 
[Clang 10.0.0 ] :: Anaconda, Inc. on darwin
Type "help", "copyright", "credits" or "license" for more information.
>>>
```
To exit the Python prompt, type `quit()`(enter) or press control-z (enter, on Windows) or control-d (macOS, Linux). 

<!-- On macOS, you may need to insert `alias python=pythonw` into your `~/.bashrc` file (or `~/.bash_profile`). -->
