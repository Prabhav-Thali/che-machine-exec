//
// Copyright (c) 2012-2019 Red Hat, Inc.
// This program and the accompanying materials are made
// available under the terms of the Eclipse Public License 2.0
// which is available at https://www.eclipse.org/legal/epl-2.0/
//
// SPDX-License-Identifier: EPL-2.0
//
// Contributors:
//   Red Hat, Inc. - initial API and implementation
//

package model

import (
	"github.com/eclipse/che-go-jsonrpc/event"
	line_buffer "github.com/eclipse/che-machine-exec/output/line-buffer"
	ws_conn "github.com/eclipse/che-machine-exec/ws-conn"
	"k8s.io/client-go/tools/remotecommand"
)

const (
	BufferSize = 8192

	// method names to send events with information about exec to the clients.
	OnExecExit  = "onExecExit"
	OnExecError = "onExecError"

	BearerTokenHeader = "X-Forwarded-Access-Token"
)

type MachineIdentifier struct {
	MachineName string `json:"machineName"`
}

type ContainerInfo struct {
	ContainerName string
	PodName       string
}

// Todo code Refactoring: MachineExec should be simple object for exec creation, without any business logic
type MachineExec struct {
	Identifier MachineIdentifier `json:"identifier"`
	Cmd        []string          `json:"cmd"`
	// Supported values for now 'shell', "", "process". If type is empty "", than type will resolved like "shell".
	Type string `json:"type"`

	Tty  bool   `json:"tty"`
	Cols int    `json:"cols"`
	Rows int    `json:"rows"`
	Cwd  string `json:"cwd"`

	ExitChan  chan bool
	ErrorChan chan error

	// unique client id, real execId should be hidden from client to prevent serialization
	ID int `json:"id"`

	ws_conn.ConnectionHandler

	MsgChan chan []byte

	// Todo Refactoring: this code is kubernetes specific. Create separated code layer and move it.
	Executor remotecommand.Executor
	SizeChan chan remotecommand.TerminalSize

	// Todo Refactoring: Create separated code layer and move it.
	Buffer *line_buffer.LineRingBuffer

	// BearerToken to have access to the kubernetes api.
	// For empty value will be created in-cluster config with service account access.
	BearerToken string
}

type ExecExitEvent struct {
	event.E `json:"-"`

	ExecId int `json:"id"`
}

func (*ExecExitEvent) Type() string {
	return OnExecExit
}

type ExecErrorEvent struct {
	event.E `json:"-"`

	ExecId int    `json:"id"`
	Stack  string `json:"stack"`
}

func (*ExecErrorEvent) Type() string {
	return OnExecError
}

type KubeConfigParams struct {
	ContainerName string `json:"container"`
	Username      string //optional, Developer in kubeconfig if empty
	BearerToken   string //evaluated from header
}
