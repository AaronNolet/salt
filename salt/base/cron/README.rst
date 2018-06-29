==============
cron-formula
==============

Install and configure cron and set up cron tasks. Tested in CentOS 6/7 and Ubuntu 12/14/16.

.. note::

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.

Available states
================

.. contents::
    :local:

``cron``
--------
Join install, configure and service states.

``install``
-----------
Install required package to run cron.

``config``
----------
Configure cron tasks based on the pillar configuration.

Remember that is you need to delete a cron task you have to set ``type`` as ``absent`` if not, the crontask will not be deleted. You can also disable a crontask using the ``commented`` keyword.

``service``
-----------
Manage the ``cron`` service. Stopping or starting it. If needed, you can disable the cron service by setting the ``enabled: False`` option in the pillar.
