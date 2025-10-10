# utils.py - librerie comuni per tutti i notebook
import sys
import os
import pandas as pd
import numpy as np
import matplotlib as mt

repo_root = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
if repo_root not in sys.path:
    sys.path.append(repo_root)

# common notebooks functions
def read_world_dataset():
    path = os.path.join(os.path.dirname(os.path.dirname(__file__)), 'data' , 'raw', 'cost-of-living.csv')
    df = pd.read_csv(path)
    return df

def read_world_mappedDataset():
    path = os.path.join(os.path.dirname(os.path.dirname(__file__)), 'data' , 'processed', 'cost-of-living-mapped.csv')
    df = pd.read_csv(path)
    return df

def read_world_colCleanDataset():
    path = os.path.join(os.path.dirname(os.path.dirname(__file__)), 'data' , 'processed', 'cost-of-living-columns-clean.csv')
    df = pd.read_csv(path)
    return df

def read_generic_csv(path, separator=''):
    df = pd.read_csv(path, sep=separator)
    return df