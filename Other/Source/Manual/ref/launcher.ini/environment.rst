.. ini-section:: [Environment]

[Environment]
=============

**Format:** arbitrary pairs

|envsub|

.. versionchanged:: 3.0
   added support for :ref:`directory variables <ref-envsub-directory>`

----

This section is for the setting of environment variables. The key names are the
environment variables, and the values are the values which are assigned to them.

There are no fixed values which must go in here; all data is in arbitrary INI
pairs. A few examples:

.. code-block:: ini

    [Environment]
    PATH=%PATH%;%PAL:AppDir%\AppName
    APPNAME_HOME=%PAL:DataDir%\settings

Here, ``PATH`` will have ``;%PAL:AppDir%\AppName`` appended to it (as
``%PATH%`` will be expanded) and ``APPNAME_HOME`` will be set to something like
``X:\PortableApps\AppNamePortable\Data\settings``.

All values are parsed in the order they are come across, and the
``[Environment]`` section is parsed before all others that can "do
anything", thus you can, in a way, store a variable if you want to, for use in
later ``[Environment]`` pairs or in another section such as a
:ini-section:`[FileWriteN]` section:

.. code-block:: ini

   [Environment]
   LongSettingFile=%PAL:DataDir%\settings\.metadata\this.is.a.long.path\and.it.gets.used.a.number.of.times\file.conf
   LongSettingFileDBS=%PAL:DataDir:DoubleBackslash%\\settings\\.metadata\\this.is.a.long.path\\and.it.gets.used.a.number.of.times\\file.conf
   SomeEnvVar=%SomeEnvVar%;%LongSettingFile%

   [FileWrite1]
   Type=Replace
   File=%LongSettingFile%
   Find=%PAL:LastDrive%\\
   Replace=%PAL:CurrentDrive%\\

   [FileWrite2]
   Type=Replace
   File=%PAL:AppDir%\AppName\setting-file.conf
   Entry=config.filename=
   Value=%LongSettingFileDBS%

If a key name has a ``~`` appended to it, it will be processed as a
:ref:`directory variable <ref-envsub-directory>`, therefore getting the same
additional variables:

.. code-block:: ini

   [Environment]
   Home~=%PAL:DataDir%\AppHome

This code will make available the following environment variables:

* ``%Home%`` -- ``X:\PortableApps\AppNamePortable\Data\AppHome``
* ``%Home:ForwardSlash%`` -- ``X:/PortableApps/AppNamePortable/Data/AppHome``
* ``%Home:DoubleBackslash%`` -- ``X:\\PortableApps\\AppNamePortable\\Data\\AppHome``
* ``%Home:java.util.prefs%`` -- ``/X:///Portable/Apps///App/Name/Portable///Data///AppHome``

For a list of the extra environment variables that the PortableApps.com Launcher
makes available, see :ref:`ref-envsub`.
