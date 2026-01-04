package templates

import (
	"bytes"
	"embed"
	"fmt"
	"os"
	"runtime"
	"strings"
	"text/template"
)

const checksumFormat = "%s %d %s\n"

//go:embed *
var templatesFS embed.FS

type Args struct {
	Rc                      string
	HookflowPath            string
	AssertHookflowInstalled bool
	Roots                   []string
}

type hookTmplData struct {
	HookName                string
	Extension               string
	HookflowPath            string
	HookflowPathCurrent     string
	Rc                      string
	Roots                   []string
	AssertHookflowInstalled bool
}

func Hook(hookName string, args Args) []byte {
	hookflowPathCurrent, err := os.Executable()
	if err != nil {
		hookflowPathCurrent = ""
	}

	buf := &bytes.Buffer{}
	t := template.Must(template.ParseFS(templatesFS, "hook.tmpl"))
	if err = t.Execute(buf, hookTmplData{
		HookName:                hookName,
		Extension:               getExtension(),
		Rc:                      args.Rc,
		AssertHookflowInstalled: args.AssertHookflowInstalled,
		Roots:                   args.Roots,
		HookflowPath:            strings.ReplaceAll(strings.TrimSpace(args.HookflowPath), "\n", ";"),
		HookflowPathCurrent:     hookflowPathCurrent,
	}); err != nil {
		panic(err)
	}

	return buf.Bytes()
}

func Config() []byte {
	tmpl, err := templatesFS.ReadFile("config.tmpl")
	if err != nil {
		panic(err)
	}

	return tmpl
}

func Checksum(checksum string, timestamp int64, hooks []string) []byte {
	return fmt.Appendf(nil, checksumFormat, checksum, timestamp, strings.Join(hooks, ","))
}

func getExtension() string {
	if runtime.GOOS == "windows" {
		return ".exe"
	}
	return ""
}
