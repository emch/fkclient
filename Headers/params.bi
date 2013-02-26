#Ifndef __HEADER_PARAMS_BI__
#define __HEADER_PARAMS_BI__

''
'' Non-configurable parameters
''

'' Game and version information
#Define APP_NAME 			"FK client "
#Define VERSION_MAIN		0
#Define VERSION_MINOR	0
#Define VERSION_DEBUG	0
#Define VERSION_MESSAGE Str(VERSION_MAIN) + "." + Str(VERSION_MINOR) + "." + Str(VERSION_DEBUG)

'' Chunks
#Define CHUNK_SIZE 			16
#Define BLOCKS_PER_CHUNK	CHUNK_SIZE * CHUNK_SIZE * CHUNK_SIZE

'' Configuration file name
#Define CONFIG_FILE_NAME	"fkclient.cfg"			'' Configuration filename

'' Log file name
#Define LOGGING_FILE_NAME	"fkclient.log"			'' Logging file name
#Define LOGGING_PREFIX		Date + " | " + Time + " | "

''
'' Default parameters in case an error occurs during configuration file retrieval
''

'' Screen parameters
#Define SCR_WIDTH_PARAM		"SCR_WIDTH"
#Define SCR_WIDTH_DEFAULT	850.0
#Define SCR_HEIGHT_PARAM	"SCR_HEIGHT"
#Define SCR_HEIGHT_DEFAULT	480.0
#Define SCR_MAXFPS_PARAM	"SCR_MAXFPS"
#Define SCR_MAXFPS_DEFAULT	60.0

'' Keyboard parameters

#endif