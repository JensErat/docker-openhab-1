#!/bin/sh
# link bindings
BINDINGS_CONFIG_FILE=$OPENHAB_DIR/configurations/bindings.list
BINDINGS_CONFIG_DIR=$OPENHAB_DIR/addons

# set current user as owner of config files
chown -R `whoami` $OPENHAB_DIR/configurations

if [ -f "$BINDINGS_CONFIG_FILE" ]
then
  # Link each line of bindingsfile
  while read -r line
  do
      BINDING_FILE_NAME=$line-$OPENHAB_VERSION.jar
      ln -s "$BINDINGS_DIR/$BINDING_FILE_NAME" "$BINDINGS_CONFIG_DIR/$BINDING_FILE_NAME"

  done < "$BINDINGS_CONFIG_FILE"
fi



# Now start openHab
if [ -n "$debug" ]; then
    /opt/openhab/start_debug.sh
else
    /opt/openhab/start.sh
fi