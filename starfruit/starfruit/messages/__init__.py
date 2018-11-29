# -*- coding: utf-8 -*-
'''
    Starfruit system models and messages.
'''

# This file is part of starfruit.

# Distributed under the terms of the last AGPL License.
# The full license is in the file LICENCE, distributed as part of this software.

__authors__ =  ['Jean Chassoul', 'Anthony Solorzano']


import uuid
from schematics import models
from schematics import types
from schematics.types import compound

class BaseResult(models.Model):
    '''
        base result
    '''
    count = types.IntType()
    page = types.IntType()

class SimpleResource(models.Model):
    '''
        Simple resource
    '''
    contains = compound.ListType(types.UUIDType())
    total = types.IntType()


class Resource(models.Model):
    ''' 
        Resource
    '''
    calls = compound.ModelType(SimpleResource)
    total = types.IntType()