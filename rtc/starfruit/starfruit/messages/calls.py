# -*- coding: utf-8 -*-
'''
    Starfruit calls message models.
'''

# This file is part of starfruit.

# Distributed under the terms of the last AGPL License.
# The full license is in the file LICENCE, distributed as part of this software.

__author__ = 'Team Machine'


import uuid

import arrow

from schematics import models
from schematics import types
from schematics.types import compound

from starfruit.messages import Resource


class Call(models.Model):
    '''
        Call schema
    '''
    uuid = types.UUIDType(default=uuid.uuid4)
    account = types.StringType(required=True)
    src = types.StringType()
    dst = types.StringType()
    dcontext = types.StringType()
    clid = types.StringType()
    channel = types.StringType()
    dstchannel = types.StringType()
    lastapp = types.StringType()
    lastdata = types.StringType()
    start = types.StringType()
    answer = types.StringType()
    end = types.StringType()
    duration = types.StringType()
    billsec = types.StringType()
    disposition = types.StringType()
    amaflags = types.StringType()
    userfield = types.StringType()
    linkedid = types.StringType()
    peeraccount = types.StringType()
    sequence = types.StringType()
    checked = types.BooleanType(default=False)
    created_by = types.StringType()
    created_at = types.TimestampType(default=arrow.utcnow().timestamp)
    last_update_by = types.StringType()
    last_update_at = types.TimestampType()
    history = compound.ListType(types.StringType())
    labels = compound.ListType(types.StringType())
    url = types.StringType()
    resource = types.StringType()
    resource_uuid = types.StringType()
    active = types.BooleanType(default=True)

class ModifyCall(models.Model):
    '''
        Modify call schema

        This model is similar to call.

        It lacks of require and default values on it's fields.

        The reason of it existence is that we need to validate
        every input data that came from outside the system, with 
        this we prevent users from using PATCH to create fields 
        outside the scope of the resource.
    '''
    uuid = types.UUIDType()
    account = types.StringType()
    src = types.StringType()
    dst = types.StringType()
    dcontext = types.StringType()
    clid = types.StringType()
    channel = types.StringType()
    dstchannel = types.StringType()
    lastapp = types.StringType()
    lastdata = types.StringType()
    start = types.StringType()
    answer = types.StringType()
    end = types.StringType()
    duration = types.StringType()
    billsec = types.StringType()
    disposition = types.StringType()
    amaflags = types.StringType()
    userfield = types.StringType()
    linkedid = types.StringType()
    peeraccount = types.StringType()
    sequence = types.StringType()
    checked = types.BooleanType()
    created_by = types.StringType()
    created_at = types.TimestampType()
    last_update_by = types.StringType()
    last_update_at = types.TimestampType()
    history = compound.ListType(types.StringType())
    labels = compound.ListType(types.StringType())
    url = types.StringType()
    resource = types.StringType()
    resource_uuid = types.StringType()
    active = types.BooleanType()